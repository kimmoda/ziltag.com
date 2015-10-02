class PagesController < ApplicationController
  def home
    if params[:src]
      @photo = Photo.find_or_create_by_source_and_href! params[:src]
      redirect_to @photo if @photo.persisted?
    else
      @photo = Photo.new
      @user = ContentProvider.new
    end
  end
end
