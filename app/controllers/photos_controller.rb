class PhotosController < ApplicationController
  def show
    @photo = Photo.find_by(source: params[:src])
    @photo ||= Photo.create remote_image_url: params[:src]
    if @photo.persisted?
      @ziltag = @photo.ziltags.includes(comments: :user).find_by id: params[:ziltag_id]
      session[:previous_photo_path] = request.fullpath
      headers.delete 'X-Frame-Options'
    else
      redirect_to root_path
    end
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to photo_path src: @photo.source
    else
      redirect_to root_path
    end
  end

  def permalink
    if @photo = Photo.find_by(slug: params[:slug])
      redirect_to photo_path src: @photo.source, ziltag_id: params[:ziltag_id]
    else
      redirect_to root_path, alert: 'Photo not found.'
    end
  end

private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
