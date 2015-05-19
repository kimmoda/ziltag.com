class PhotosController < ApplicationController
  def index
    @photos = Photo.includes(:user, :ziltaggings).limit(10)
  end
end
