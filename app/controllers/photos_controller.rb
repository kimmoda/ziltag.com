class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user, ziltaggings: [:post]).order('created_at DESC').limit(10)
  end

  def show
    @photo = Photo.includes(posts: :user).find params[:id]
  end
end
