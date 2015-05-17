class FollowingController < ApplicationController
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
    @follower = User.find(params[:follower_id])
    @leader = User.find(params[:leader_id])
  end

end
