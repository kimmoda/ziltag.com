class Api::V1::PhotosController < ApiController
  before_action :set_photo, only: :show
  before_action :set_user_photo, only: %i[update destroy]

  def index
    @photos = Photo.includes(:ziltaggings).order('id DESC').page(params[:page])
  end

  def create
    @photo = Photo.find_or_create_by_url!(photo_params)
    render :show
  rescue
    head :unprocessable_entity
  end

  def update
    if @photo.update(photo_params)
      render :show
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    head :ok
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def set_user_photo
      @photo = current_user.photos.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:image, :remote_image_url)
    end
end
