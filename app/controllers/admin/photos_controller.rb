class Admin::PhotosController < AdminController
  before_action :set_admin_photo, only: [:show, :edit, :update, :destroy]

  # GET /admin/photos
  def index
    @admin_photos = Admin::Photo.includes(:user).order('id DESC').page(params[:page])
    @admin_photos = Admin::Select2.query(@admin_photos, :image, params[:q])
  end

  # GET /admin/photos/1
  def show
  end

  # GET /admin/photos/new
  def new
    @admin_photo = Admin::Photo.new
  end

  # GET /admin/photos/1/edit
  def edit
  end

  # POST /admin/photos
  def create
    @admin_photo = Admin::Photo.new(admin_photo_params)

    if @admin_photo.save
      redirect_to @admin_photo, notice: t('scaffold.created', model: Admin::Photo.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/photos/1
  def update
    if @admin_photo.update(admin_photo_params)
      redirect_to @admin_photo, notice: t('scaffold.updated', model: Admin::Photo.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/photos/1
  def destroy
    @admin_photo.destroy
    redirect_to admin_photos_url, notice: t('scaffold.destroied', model: Admin::Photo.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_photo
      @admin_photo = Admin::Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_photo_params
      params.require(:admin_photo).permit(:user_id, :source, :image, :image_cache, :remove_image, :remote_image_url)
    end
end
