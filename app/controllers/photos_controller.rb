class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user, ziltaggings: [:post]).limit(10)
  end
end
