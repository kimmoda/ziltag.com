class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_post, only: :show
  before_action :set_user_post, only: %i[update destroy]

  def index
    @posts = Post.all.order('id DESC').page(params[:page])
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      render :show
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :published)
    end
end
