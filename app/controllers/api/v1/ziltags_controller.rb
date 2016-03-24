class Api::V1::ZiltagsController < ApiController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_ziltag, only: %i[update destroy]

  def index
    find_or_create_map = FindOrCreateMap.call(params[:token], params[:src], params[:href], params[:width], params[:height])
    if find_or_create_map.success?
      @photo = find_or_create_map.results[:photo]
      PhotoJob.perform_later @photo, params[:src] unless @photo.image?
    else
      render json: {error: find_or_create_map.errors.values.first}
    end
  end

  def show
    @ziltag = Ziltag.find_by!(slug: params[:id])
  end

  def create
    @ziltag = current_user.ziltags.new(ziltag_params)

    if @ziltag.save
      NotifyOfZiltag.new(@ziltag).call
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
