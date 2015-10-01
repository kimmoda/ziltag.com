class Api::V1::ZiltagsController < ApiController
  def index
    @photo = Photo.find_or_create_by_source_and_href! params[:source], params[:href]
    @ziltags = @photo.ziltags.includes(:user).select(&:confirmed?)
  end
end
