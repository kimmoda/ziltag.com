class Api::V1::ZiltagsController < ApiController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_ziltag, only: %i[update destroy]

  def index
    @photo = Photo.find_or_create_by_source_and_href_and_token! params[:src], params[:href], params[:token], width: params[:width], height: params[:height]
  rescue ActiveRecord::RecordInvalid
    render json: {errors: $!.record.errors.messages}, status: 400
  rescue
    render json: {errors: $!.to_s}, status: 400
  end

  def show
    @ziltag = Ziltag.find_by!(slug: params[:id])
  end

  def create
    @photo = Photo.find_by slug: ziltag_params[:map_id]
    @ziltag_params = ziltag_params
    @ziltag_params[:photo_id] = @photo.id
    @ziltag_params.delete(:map_id)
    @ziltag = current_user.ziltags.new(@ziltag_params)

    if @ziltag.save
      render :show
    else
      render json: {errors: @ziltag.errors.full_messages}
    end
  end

  def update
    if @ziltag.update ziltag_params
      render :show
    else
      render json: {errors: @ziltag.errors.full_messages}
    end
  end

  def destroy
    @ziltag.destroy
    head :no_content
  end

private

  def ziltag_params
    params.require(:ziltag).permit(:x, :y, :map_id, :content)
  end

  def set_ziltag
    @ziltag = current_user.ziltags.find_by! slug: params[:id]
  end

end
