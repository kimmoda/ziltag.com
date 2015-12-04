class Api::V1::UsersController < ApiController
  def me
    if @user = current_user
      render :show
    else
      render json: {}
    end
  end
end
