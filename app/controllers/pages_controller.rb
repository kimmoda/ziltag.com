class PagesController < ApplicationController
  before_action :must_sign_in!, :must_be_content_provider!, only: %i[username update_username install]

  def home
    @photo = Photo.new
    @user = ContentProvider.new
  end

  def username
    redirect_to install_path if current_user.username.present?
  end

  def update_username
    if current_user.update params.require(:content_provider).permit(:username)
      redirect_to install_path
    else
      flash.now[:alert] = 'Please check your input value.'
      render :username
    end
  end

  def platform
  end

  def update_platform
  end

  def install
    @box = current_user.box
  end

private

  def must_sign_in!
    redirect_to root_path, alert: 'You are not signed in.' unless user_signed_in?
  end

  def must_be_content_provider!
    redirect_to root_path, alert: 'You are not a content provider.' unless current_user.is_a? ContentProvider
  end

end
