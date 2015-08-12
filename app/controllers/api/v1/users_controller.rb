class Api::V1::UsersController < ApiController
  before_action :set_user

  def show
  end

  def update
    if @user == current_user && @user.update(user_params)
      render :show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

private

  def set_user
    @user = params[:id] == 'me' ? current_user : User.find_by!(username: params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar, :cover)
  end

end