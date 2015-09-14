class Api::V1::ZiltagsController < ApiController
  def index
    @ziltags = Ziltag.by_image_source(params[:source])
  end
end
