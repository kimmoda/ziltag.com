class FollowingController < ApplicationController
  before_action :authenticate_user!
  before_action :set_follower_leader

  def follow
    @follower.follow!(@leader)
    head :ok
  end

  def unfollow
    @follower.unfollow!(@leader)
    head :ok
  end

private

  def set_follower_leader
    @follower = current_user
    @leader = User.find(params[:leader_id])
  end

end
