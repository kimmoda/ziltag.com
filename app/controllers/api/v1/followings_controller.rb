class Api::V1::FollowingsController < ApiController
  def create
    current_user.follow! User.find(params[:leader_id])
    head :ok
  end

  def destroy
    current_user.unfollow! User.find(params[:leader_id])
    head :ok
  end

end
