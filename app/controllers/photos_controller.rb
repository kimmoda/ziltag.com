class PhotosController < ApplicationController
  before_action :authenticate_user!, only: :create
  layout 'sidebar'.freeze

  def index
    @photos = Photo.has_ziltaggings.includes(:user, ziltaggings: [:post]).order('created_at DESC').page(params[:page]).per(10)
    render @photos if params[:scroll]
  end

  def show
    @photo = Photo.includes(posts: :user).find params[:id]
  end

  # POST /photos.json
  def create
    photo = Photo.find_or_create_by_url!(photo_params)
    render json: {id: photo.id}
  end

private

  def photo_params
    params.require(:photo).permit(:image, :remote_image_url)
  end
end
