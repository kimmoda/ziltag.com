class Api::V1::ZiltagsController < ApiController
  def index
    @photo = Photo.find_or_create_by_source_and_href! params[:src], params[:href]
    @ziltags = @photo.ziltags.includes(:user).select(&:confirmed?)
  rescue ActiveRecord::RecordInvalid
    render json: {errors: $!.record.errors.messages}, status: 400
  end
end
