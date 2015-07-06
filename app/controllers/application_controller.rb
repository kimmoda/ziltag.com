class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :set_login, :set_flash if Rails.env.development?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :email << :avatar << :avatar_cache
    devise_parameter_sanitizer.for(:sign_in) << :login
    devise_parameter_sanitizer.for(:account_update).concat %i[email avatar avatar_cache remove_avatar cover cover_cache remove_cover]
  end

  if Rails.env.development?
    def set_login
      if params.has_key? :sign_in
        sign_in(:user, User.first)
      elsif params.has_key? :sign_out
        sign_out(:user)
      end
    end

    def set_flash
      if params.has_key? :flash
        flash.now[:alert] = '警告訊息'
        flash.now[:notice] = '通知訊息'
      end
    end
  end

end
