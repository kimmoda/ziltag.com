class Admin::TagsController < AdminController
  before_action :set_admin_tag, only: [:show, :edit, :update, :destroy]

  # GET /admin/tags
  def index
    @admin_tags = Admin::Tag.all.order('id DESC').page(params[:page])
  end

  # GET /admin/tags/1
  def show
  end

  # GET /admin/tags/new
  def new
    @admin_tag = Admin::Tag.new
  end

  # GET /admin/tags/1/edit
  def edit
  end

  # POST /admin/tags
  def create
    @admin_tag = Admin::Tag.new(admin_tag_params)

    if @admin_tag.save
      redirect_to @admin_tag, notice: t('scaffold.created', model: Admin::Tag.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/tags/1
  def update
    if @admin_tag.update(admin_tag_params)
      redirect_to @admin_tag, notice: t('scaffold.updated', model: Admin::Tag.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/tags/1
  def destroy
    @admin_tag.destroy
    redirect_to admin_tags_url, notice: t('scaffold.destroied', model: Admin::Tag.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tag
      @admin_tag = Admin::Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_tag_params
      params.require(:admin_tag).permit(:name)
    end
end
