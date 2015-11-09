require 'service_url_converter'
class PagesController < ApplicationController
  before_action :must_sign_in!, :must_be_content_provider!, only: %i[username update_username platform update_platform install]
  before_action :must_have_username!, only: %i[platform update_platform install]
  before_action :must_have_platform!, only: %i[install]

  def home
    @photo = Photo.new
    @user = ContentProvider.new
  end

  def username
    redirect_to install_path if current_user.username.present?
  end

  def update_username
    if current_user.update params.require(:content_provider).permit(:username)
      redirect_to platform_path
    else
      flash.now[:alert] = 'Please check your input value.'
      render :username
    end
  end

  def update_platform
    if current_user.box.update url: ServiceURLConverter.convert(params)
      redirect_to install_path
    else
      render :platform, alert: 'Invalid input.'
    end
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

  def must_have_username!
    redirect_to username_path if current_user.username.blank?
  end

  def must_have_platform!
    redirect_to platform_path if current_user.box.url.blank?
  end

end
