class PhotosController < ApplicationController
  def show
    @photo = Photo.includes(:ziltags).find_by(slug: params[:slug])
    @ziltag = @photo.ziltags.includes(comments: :user).find_by slug: params[:ziltag_slug]
    session[:previous_photo_path] = request.fullpath
    headers.delete 'X-Frame-Options'
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to @photo
    else
      redirect_to root_path
    end
  end

private

  def photo_params
    params.require(:photo).permit(:image)
  end
end
