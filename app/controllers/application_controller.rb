# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_sign_in, if: -> { request.host =~ /^(?:staging\.ziltag\.com|localhost)$/ || Rails.env.development? }

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(username email type))
    devise_parameter_sanitizer.permit(:sign_in, keys: %i(sign_in))
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i(email avatar avatar_cache remove_avatar url)
    )
  end

  def set_sign_in
    if params.key? :sign_in
      user = User.find_by(username: params[:id]) || User.first
      if params[:confirmed] == 'false'
        user.update confirmed_at: nil, confirmation_sent_at: Time.now
      elsif !user.confirmed?
        user.update confirmed_at: Time.now
      end
      sign_in(:user, user)
    elsif params.key? :sign_out
      sign_out(:user)
    end
  end

  def track(event, status = 'success')
    Track.create(
      event: event, status: status,
      token: (session[:tracking_token] ||= SecureRandom.hex),
      user_agent: request.headers['User-Agent'],
      referer: request.headers['Referer']
    )
  end
end
