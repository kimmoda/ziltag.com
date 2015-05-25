class CollectingController < ApplicationController
  before_action :authenticate_user!

  def collect
    current_user.collect! Post.find(params[:post_id])
    head :ok
  end

  def uncollect
    current_user.uncollect! Post.find(params[:post_id])
    head :ok
  end

end
