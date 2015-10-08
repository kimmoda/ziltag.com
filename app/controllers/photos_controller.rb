class PhotosController < ApplicationController
  def show
    @photo = Photo.find_by!(slug: params[:slug])
    @ziltags = @photo.ziltags.confirmed(current_user)
    @ziltag = @photo.ziltags.find_by(slug: params[:ziltag_slug])
    @comments = @ziltag.comments.includes(:user).confirmed(current_user) if @ziltag
    @user = User.new unless user_signed_in?
    session[:previous_photo_path] = request.fullpath
  end

end
