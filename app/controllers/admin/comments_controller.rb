class Admin::CommentsController < AdminController
  before_action :set_admin_comment, only: [:show, :edit, :update, :destroy]

  # GET /admin/comments
  def index
    @admin_comments = Admin::Comment.includes(:user, :photo, :root).order('comments.id DESC').page(params[:page])
    @admin_comments = Admin::Select2.query(@admin_comments, :text, params[:q])
    @admin_comments = @admin_comments.where(photos: {source: params[:image_url]}, root: nil) if params[:image_url]
  end

  # GET /admin/comments/1
  def show
  end

  # GET /admin/comments/new
  def new
    @admin_comment = Admin::Comment.new
    if params[:photo_id].present? && params[:x].present? && params[:y].present?
      photo = Photo.find params[:photo_id]
      @admin_comment.assign_attributes(photo: photo, x: params[:x], y: params[:y])
    end
  end

  # GET /admin/comments/1/edit
  def edit
  end

  # POST /admin/comments
  def create
    @admin_comment = Admin::Comment.new(admin_comment_params)

    if @admin_comment.save
      redirect_to @admin_comment, notice: t('scaffold.created', model: Admin::Comment.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/comments/1
  def update
    if @admin_comment.update(admin_comment_params)
      redirect_to @admin_comment, notice: t('scaffold.updated', model: Admin::Comment.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/comments/1
  def destroy
    @admin_comment.destroy
    redirect_to admin_comments_url, notice: t('scaffold.destroied', model: Admin::Comment.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_comment
      @admin_comment = Admin::Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_comment_params
      params.require(:admin_comment).permit(
        :text, :email, :x, :y, :comment_id, :photo_id
      )
    end
end
