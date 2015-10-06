class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale, :set_seo
  before_action :set_login, :set_flash if Rails.env.development?
  after_action :enable_iframe # TODO: It's not safe

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :email << :type
    devise_parameter_sanitizer.for(:sign_in) << :login
    devise_parameter_sanitizer.for(:account_update).concat %i[email avatar avatar_cache remove_avatar cover cover_cache remove_cover]
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_seo
    @seo = {
      meta: {
        description: t('site.description')
      },
      google: {
        name: t('site.name'),
        description: t('site.description'),
        image: 'logo.png',
        item_type: :Article
      },
      og: {
        title: t('site.name'),
        url: request.url,
        type: :website,
        description: t('site.description'),
        image: 'logo.png'
      }
    }
  end

  def default_url_options options = {}
     {locale: I18n.locale == I18n.default_locale ? nil : I18n.locale}
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

private

  def after_sign_in_path_for(resource_or_scope)
    if current_user.is_a? ContentProvider
      if current_user.confirmed?
        install_path
      else
        username_path
      end
    else
      session[:previous_photo_path] || root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_photo_path] || root_path
  end

  def enable_iframe
    headers.delete 'X-Frame-Options'
  end

end
