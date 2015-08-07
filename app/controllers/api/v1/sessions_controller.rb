class Api::V1::SessionsController < ApiController
  def create
    @user = User.find_by_email(params[:login]) || User.find_by_username(params[:login])
    if @user && @user.valid_password?(params[:password])
      sign_in(@user)
    else
      head 400
    end
  end
end
