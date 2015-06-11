class PhotosController < ApplicationController
  layout 'sidebar'.freeze

  def index
    @photos = Photo.includes(:user, ziltaggings: [:post]).order('created_at DESC').page(params[:page]).per(10)
    render @photos if params[:scroll]
  end

  def show
    @photo = Photo.includes(posts: :user).find params[:id]
  end

end
