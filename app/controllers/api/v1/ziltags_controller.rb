class Api::V1::ZiltagsController < ApiController
  def index
    @photo = Photo.find_by source: params[:src]
    @photo ||= Photo.create remote_image_url: params[:src]
    @ziltags = @photo.ziltags.includes(:user).select(&:confirmed?)
  end
end
