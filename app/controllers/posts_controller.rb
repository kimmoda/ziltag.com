class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[update destroy]

  # GET /posts.json
  def index
    @posts = current_user.posts.page(params[:page]).per(10)
  end

  # POST /posts.json
  def create
    @post = current_user.posts.create! post_params
    @ziltagging = @post.ziltaggings.create! ziltagging_params if params[:ziltagging].present?
  end

  # PUT /posts/:id.json
  def update
    @post.update! post_params
    head :ok
  end

  # DELETE /posts/:id.json
  def destroy
    @post.destroy
    head :ok
  end

private

  def set_post
    @post = current_user.posts.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def ziltagging_params
    params.require(:ziltagging).permit(:post_id, :photo_id, :x, :y)
  end

end
