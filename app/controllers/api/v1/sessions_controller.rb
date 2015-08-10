class Api::V1::SessionsController < ApiController
  skip_before_action :authenticate_user!, only: :create
  def create
    @user = User.find_by_email(params[:login]) || User.find_by_username(params[:login])
    if @user && @user.valid_password?(params[:password])
      sign_in(@user)
    else
      head 401
    end
  end

  def destroy
    sign_out current_user
    head 200
  end
end
