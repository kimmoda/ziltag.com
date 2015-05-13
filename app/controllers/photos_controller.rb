class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user).limit(10)
  end
end
