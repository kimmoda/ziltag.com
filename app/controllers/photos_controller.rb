class PhotosController < ApplicationController
  before_action :authenticate_user!, only: :create
  layout 'sidebar'.freeze

  def index
    @photos = Photo.includes(:user, ziltaggings: [:post]).order('created_at DESC').page(params[:page]).per(10)
    render @photos if params[:scroll]
  end

  def show
    @photo = Photo.includes(posts: :user).find params[:id]
  end

  # POST /photos.json
  def create
    photo = current_user.photos.create! params.require(:photo).permit(:image, :source)
    render json: {id: photo.id}
  end

end
