class PostsController < ApplicationController
  before_action :authenticate_user!
  # POST /posts.json
  def create
    @post = current_user.posts.create! post_params
  end

private

  def post_params
    params.require(:post).permit(:title, :content, ziltaggings_attributes: [:id, :_destroy, :photo_id, :x, :y])
  end

end
