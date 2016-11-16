# frozen_string_literal: true
class Api::V1::ZiltagsController < ApiController
  before_action :set_ziltag, only: %i(update destroy)

  def index
    find_or_create_map = FindOrCreateMap.perform(params[:token], params[:src], params[:href], params[:width], params[:height], map_namespace)
    if find_or_create_map.success?
      @photo = find_or_create_map.photo
    else
      render json: { error: find_or_create_map.error }
    end
  end

  def show
    @ziltag = Ziltag.find_by!(natural_id: params[:id])
  end

  def create
    user = if Rails.env.production? && Settings.host == 'ziltag.com' &&
              demo_token == Photo.find_by(natural_id: ziltag_params[:map_id])&.website&.token
      demo_user
    else
      authenticate_user!
      current_user
    end
    create_ziltag = CreateZiltag.perform(
      user,
      ziltag_params[:map_id], ziltag_params[:x], ziltag_params[:y],
      ziltag_params[:content]
    )
    if create_ziltag.success?
      @ziltag = create_ziltag.ziltag
      render :show
    else
      render json: { errors: [create_ziltag.error] }
    end
  end

  def update
    if @ziltag.update ziltag_params
      NotifySSE.perform(:update, @ziltag)
      render :show
    else
      render json: { errors: @ziltag.errors.full_messages }
    end
  end

  def destroy
    @ziltag.destroy
    NotifySSE.perform(:delete, @ziltag)
    head :no_content
  end

  private

  def map_namespace
    @_map_namespace ||= request.referer && Rack::Utils.parse_nested_query(URI(request.referer).query)['ns']
  end

  def ziltag_params
    params.require(:ziltag).permit(:x, :y, :map_id, :content)
  end

  def set_ziltag
    user = if Rails.env.production? && Settings.host == 'ziltag.com' &&
              demo_token == Ziltag.find_by(natural_id: params[:id])&.photo&.website&.token
      demo_user
    else
      authenticate_user!
      current_user
    end
    @ziltag = user.ziltags.find_by! natural_id: params[:id]
  end
end
