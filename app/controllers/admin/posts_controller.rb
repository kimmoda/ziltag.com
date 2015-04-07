class Admin::PostsController < AdminController
  before_action :set_admin_post, only: [:show, :edit, :update, :destroy]

  # GET /admin/posts
  def index
    @admin_posts = Admin::Post.all.order('id DESC').page(params[:page])
  end

  # GET /admin/posts/1
  def show
  end

  # GET /admin/posts/new
  def new
    @admin_post = Admin::Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts
  def create
    @admin_post = Admin::Post.new(admin_post_params)

    if @admin_post.save
      redirect_to @admin_post, notice: t('scaffold.created', model: Admin::Post.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/posts/1
  def update
    if @admin_post.update(admin_post_params)
      redirect_to @admin_post, notice: t('scaffold.updated', model: Admin::Post.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/posts/1
  def destroy
    @admin_post.destroy
    redirect_to admin_posts_url, notice: t('scaffold.destroied', model: Admin::Post.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_post
      @admin_post = Admin::Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_post_params
      params.require(:admin_post).permit(:user_id, :title, :content)
    end
end
