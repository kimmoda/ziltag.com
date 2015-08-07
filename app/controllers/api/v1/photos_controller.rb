class Api::V1::PhotosController < ApiController
  before_action :set_photo, only: :show
  before_action :set_user_photo, only: %i[update destroy]

  def index
    @photos = Photo.includes(:ziltaggings).order('id DESC').page(params[:page])
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      render :show
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
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
      params.require(:photo).permit(:user_id, :title, :content, :published)
    end
end
