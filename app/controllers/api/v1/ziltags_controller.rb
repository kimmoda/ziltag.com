class Api::V1::ZiltagsController < ApiController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_ziltag, only: %i[update destroy]

  def index
    find_or_create_map = FindOrCreateMap.call(params[:token], params[:src], params[:href], params[:width], params[:height])
    if find_or_create_map.success?
      @photo = find_or_create_map[:photo]
    else
      render json: {error: find_or_create_map[:error]}
    end
  end

  def show
    @ziltag = Ziltag.find_by!(slug: params[:id])
  end

  def create
    create_ziltag = CreateZiltag.call(
      current_user,
      ziltag_params[:map_id], ziltag_params[:x], ziltag_params[:y],
      ziltag_params[:content]
    )
    if create_ziltag.success?
      @ziltag = create_ziltag.context[:ziltag]
      render :show
    else
      render json: {errors: [create_ziltag.context[:error]]}
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
