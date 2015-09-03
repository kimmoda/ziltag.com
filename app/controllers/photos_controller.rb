class PhotosController < ApplicationController
  def show
    @photo = Photo.find_by(source: params[:source])
    @photo ||= Photo.create remote_image_url: params[:source]
    if @photo.persisted?
      @sticker = @photo.stickers.find_by id: params[:sticker_id]
    else
      redirect_to root_path
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photo_path source: @photo.source
    else
      redirect_to home_path
    end
  end

  def permalink
    if @photo = Photo.find_by(id: params[:photo_id])
      redirect_to photo_path source: @photo.source, sticker_id: params[:sticker_id]
    else
      redirect_to root_path, alert: 'Photo not found.'
    end
  end

private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
