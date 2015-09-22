class PagesController < ApplicationController
  def home
    if params[:src]
      @photo = Photo.find_by(source: params[:src])
      @photo ||= Photo.create remote_image_url: params[:src]
      redirect_to @photo if @photo.persisted?
    else
      @photo = Photo.new
      @user = ContentProvider.new
    end
  end

  def foo
    render text: 'foo' 
  end
end
