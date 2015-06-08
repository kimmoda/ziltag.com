class PostsController < ApplicationController
  before_action :authenticate_user!
  # POST /posts.json
  def create
    @post = current_user.posts.create! params.require(:post).permit(:title, :content)
    head :ok
  end

end
