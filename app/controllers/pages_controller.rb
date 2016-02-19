require 'service_url_converter'
class PagesController < ApplicationController
  def home
    @guest = Guest.new
    track 'visit-home'
  end

  def register
    @guest = Guest.new(email: params.require(:guest)[:email])
    if @guest.valid_email?
      session[:guest][:email] = params[:guest][:email]
      redirect_to username_path
      track 'input-email'
    else
      @error = @guest.user.errors[:email].first
      render :home
      track 'input-email', 'failure'
    end
  end

  def username
    @guest = Guest.new
    track 'visit-username'
  end

  def update_username
    @guest = Guest.new(username: params.require(:guest)[:username])
    if @guest.valid_username?
      session[:guest][:username] = params[:guest][:username]
      redirect_to platform_path
      track 'input-username'
    else
      @error = @guest.user.errors[:username].first
      render :username
      track 'input-username', 'failure'
    end
  end

  def platform
    @guest = Guest.new
    track 'visit-site-info'
  end

  def update_platform
    url = ServiceURLConverter.convert(params)
    @guest = Guest.new(url: url)
    if @guest.valid_url?
      session[:guest][:url] = url
      sign_in(Guest.new(session[:guest].symbolize_keys).create_user!)
      session.delete :guest
      redirect_to install_path
      track 'input-site-info'
    else
      @error = @guest.box.errors[:url].first
      render :platform
      track 'input-site-info', 'failure'
    end
  rescue ServiceURLConverter::BlankBlogID
    @error = 'Blog ID can not be blank'
    render :platform
    track 'input-site-info', 'failure'
  end

  def install
    @box = current_user.box
    track 'visit-installation'
  end

private

  def must_sign_in!
    redirect_to root_path, alert: 'You are not signed in.' unless user_signed_in?
  end

  def must_be_content_provider!
    redirect_to root_path, alert: 'You are not a content provider.' unless current_user.is_a? ContentProvider
  end

  def must_have_username!
    redirect_to username_path if current_user.username.blank?
  end

  def must_have_platform!
    redirect_to platform_path if current_user.box.url.blank?
  end

end
