class PhotosController < ApplicationController
  def show
    @photo = Photo.find_by(source: params[:source])
    @photo ||= Photo.create remote_image_url: params[:source]
    if @photo.persisted?
      @sticker = @photo.stickers.includes(comments: :user).find_by id: params[:sticker_id]
      session[:previous_photo_path] = request.fullpath
      headers.delete 'X-Frame-Options'
    else
      redirect_to root_path
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photo_path source: @photo.source
    else
      redirect_to root_path
    end
  end

  def permalink
    if @photo = Photo.find_by(slug: params[:slug])
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
