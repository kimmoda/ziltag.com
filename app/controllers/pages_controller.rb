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

  def update_username
    if current_user.update params.require(:content_provider).permit(:username)
      redirect_to install_path, notice: 'updated'
    else
      flash.now[:alert] = 'Please check your input value.'
      render :username
    end
  end
end
