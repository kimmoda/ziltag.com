class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

  def create
    @user = User.find_for_database_authentication(sign_in: params[:user][:sign_in])
    if @user && @user.valid_password?(params[:user][:password])
      sign_in(@user)
      render
    else
      render json: {error: 'invalid sign in name or password'}
    end
  end

private

  def set_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
