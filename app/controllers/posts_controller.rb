class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]

  # GET /posts.json
  def index
    @posts = current_user.posts.page(params[:page]).per(10)
  end

  # GET /posts/:id.json
  def show
  end

  # POST /posts.json
  def create
    @post = current_user.posts.create! post_params
    @ziltagging = @post.ziltaggings.create! ziltagging_params if params[:ziltagging].present?
  end

  # PUT /posts/:id.json
  def update
    @post.update! post_params
    render :show
  end

  # DELETE /posts/:id.json
  def destroy
    @ziltagging_ids = @post.ziltaggings.pluck(:id)
    @post.destroy
  end

private

  def set_post
    @post = current_user.posts.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :tag_list)
  end

  def ziltagging_params
    params.require(:ziltagging).permit(:post_id, :photo_id, :x, :y)
  end

end
