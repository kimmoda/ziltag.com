# frozen_string_literal: true
class Api::V1::Users::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

  def resend
    user = if user_signed_in?
             current_user
           else
             User.find_by(email: params[:email])
    end

    if user
      SendWelcomeEmailJob.perform_later(user)
      render json: {}
    else
      render json: { error: 'user not found' }
    end
  end

  private

  def set_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
