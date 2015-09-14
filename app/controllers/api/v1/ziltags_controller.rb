class Api::V1::ZiltagsController < ApiController
  def index
    if params[:src]
      @photo = Photo.find_by source: params[:src]
      @photo ||= Photo.create remote_image_url: params[:src]
      @ziltags = @photo.ziltags.includes(:user)
      headers['X-Map'] = @photo.slug
    else
      @ziltags = Ziltag.all.page(params[:page])
    end
  end
end
