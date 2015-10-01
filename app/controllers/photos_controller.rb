class PhotosController < ApplicationController
  def show
    @photo = Photo.includes(ziltags: [:user, {comments: :user}]).find_by!(slug: params[:slug])
    @ziltag = @photo.ziltags.find{|ziltag| ziltag.slug == params[:ziltag_slug] }
    @user = User.new unless user_signed_in?
    session[:previous_photo_path] = request.fullpath
    headers.delete 'X-Frame-Options'
  end

end
