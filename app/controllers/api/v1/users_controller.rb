# frozen_string_literal: true
class Api::V1::UsersController < ApiController
  def me
    @user = if Rails.env.production? && Settings.host == 'ziltag.com' && (
                 demo_token == me_params[:token] ||
                 demo_token == Photo.find_by(natural_id: me_params[:ziltag_map_id])&.website&.token
               )
      demo_user
    else
      current_user
    end

    result = GetUserPermissionsByParams.perform(@user, me_params)
    if result.success?
      @permissions = result.permissions
      render :show
    else
      render json: { error: result.error }
    end
  end

  def me_params
    params.permit(:token, :href, :ziltag_id, :ziltag_map_id)
  end
end
