class PhotosController < ApplicationController
  def show
    @photo = Photo.includes(ziltags: [:user, {comments: :user}]).find_by!(slug: params[:slug])
    @ziltag = @photo.ziltags.find{|ziltag| ziltag.slug == params[:ziltag_slug] }
    @user = User.new unless user_signed_in?
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
