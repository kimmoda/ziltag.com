class ApplicationController < ActionController::Base
  MOBILE_USER_AGENTS_REGEXP =  /palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|mobile|zune/i
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :set_sign_in, if: ->{ request.host =~ /^(?:staging\.ziltag\.com|localhost)$/ || Rails.env.development? }
  after_action :enable_iframe # TODO: It's not safe

protected

  def mobile?
    request.user_agent =~ MOBILE_USER_AGENTS_REGEXP
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email type])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[sign_in])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email avatar avatar_cache remove_avatar url])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options options = {}
     {locale: I18n.locale == I18n.default_locale ? nil : I18n.locale}
  end

  def set_sign_in
    if params.has_key? :sign_in
      user = User.find_by(username: params[:id]) || User.first
      if params[:confirmed] == 'false'
        user.update confirmed_at: nil, confirmation_sent_at: Time.now
      elsif !user.confirmed?
        user.update confirmed_at: Time.now
      end
      sign_in(:user, user)
    elsif params.has_key? :sign_out
      sign_out(:user)
    end
  end

  def track event, status = 'success'
    Track.create({
      event: event,
      status: status,
      token: (session[:tracking_token] ||= SecureRandom.hex),
      user_agent: request.headers['User-Agent'],
      referer: request.headers['Referer']
    })
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
    request.referer || root_path
  end

  def enable_iframe
    headers.delete 'X-Frame-Options'
  end

end
