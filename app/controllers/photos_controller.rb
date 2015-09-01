class PhotosController < ApplicationController
  def show
    @photo = Photo.find params[:id]
    @sticker = Sticker.find_by id: params[:sticker_id]
  end

  def create
    @photo = Photo.find_or_create_by_url!(photo_params)
    redirect_to @photo
  rescue
    redirect_to home_path
  end

private

  def photo_params
    params.require(:photo).permit(:image, :remote_image_url)
  end
end
