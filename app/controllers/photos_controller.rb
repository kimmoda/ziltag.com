class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user, ziltaggings: [:post]).order('created_at DESC').limit(10)
  end
end
