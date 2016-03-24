class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

  def create
    authenticate_user = AuthenticateUser.call(params[:user][:sign_in], params[:user][:password])
    if authenticate_user.success?
      @user = authenticate_user.results[:user]
      sign_in(@user)
      render
    else
      render json: {error: authenticate_user.errors[:base]}
    end
  end

private

  def set_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
