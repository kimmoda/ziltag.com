class Api::V1::ZiltagsController < ApiController
  include ActionController::Live
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_ziltag, only: %i[update destroy]

  def index
    @photo = Photo.find_or_create_by_source_and_href_and_token! params[:src], params[:href], params[:token]
  rescue ActiveRecord::RecordInvalid
    render json: {errors: $!.record.errors.messages}, status: 400
  end

  def show
    @ziltag = Ziltag.find_by!(slug: params[:id])
  end

  def create
    @ziltag = current_user.ziltags.new(ziltag_params)
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

  def stream
    @ziltag = Ziltag.find_by!(slug: params[:id])
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Access-Control-Allow-Origin'] = '*'
    Thread.new{
      begin
        sse = SSE.new(response.stream)
        Ziltag.connection.execute "LISTEN slug_#{@ziltag.slug}"
        loop do
          Ziltag.connection.raw_connection.wait_for_notify(60) do |event, pid, payload|
            action, underscore, id = payload.split('_')
            record = underscore.classify.constantize.find(id)
            sse.write(render_to_string(partial: underscore, object: record), event: [action, underscore].join('_'))
          end
          sse.write('', event: '_live')
        end
      ensure
        Ziltag.connection.execute "UNLISTEN slug_#{@ziltag.slug}"
        sse.close
      end
    }.join
  end

private

  def ziltag_params
    params.require(:ziltag).permit(:x, :y, :photo_id, :content)
  end

  def set_ziltag
    @ziltag = current_user.ziltags.find_by! slug: params[:id]
  end

end
