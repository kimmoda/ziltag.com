class Api::V1::UsersController < ApiController
  def me
    if @user = current_user
      result = GetUserPermissionsByParams.perform(@user, me_params)
      if result.success?
        @permissions = result.permissions
        render :show
      else
        render json: { error: result.error }
      end
    else
      render json: {}
    end
  end

  def me_params
    params.permit(:token, :href, :ziltag_id, :ziltag_map_id)
  end
end
