class Api::V1::ZiltagsController < ApiController
  def index
    @photo = Photo.find_or_create_by_source_and_href_and_token! params[:src], params[:href], params[:token]
  rescue ActiveRecord::RecordInvalid
    render json: {errors: $!.record.errors.messages}, status: 400
  end
end
