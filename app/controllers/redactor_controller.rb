class RedactorController < ApplicationController
  def images
    photo = Photo.create! image: params[:file]
    render json: {filelink: photo.image_url}
  end
end
