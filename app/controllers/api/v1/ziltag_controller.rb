class Api::V1::ZiltagController < ApiController
  ALLOWED_TAGGABLE_TYPES = %w[post]

  before_action :authenticate_user!, only: :ziltag
  before_action :set_ziltaggable_type!, only: :ziltag


  # POST /api/v1/ziltag
  def ziltag
    @ziltag = Abstract::Ziltag.new({
      photo: Photo.find_or_create_by_url!(photo_params),
      ziltaggable: ziltaggable_new,
      ziltagging: Ziltagging.new(ziltagging_params)
    })
    @ziltag.save!
  rescue
    if @ziltag
      render json: {
        photo: @ziltag.photo.errors,
        ziltaggable: @ziltag.ziltaggable.errors,
        ziltagging: @ziltag.ziltagging.errors
      }, status: :unprocessable_entity
    else
      render json: {error: $@}
    end
  end

private

  def set_ziltaggable_type!
    params.keys.each do |key|
      if ALLOWED_TAGGABLE_TYPES.include? key
        @ziltaggable_type = key
        break
      end
    end
  end

  def ziltaggable_new
    ziltaggable = @ziltaggable_type.classify.constantize.new ziltaggable_params
    ziltaggable.user = current_user
    ziltaggable
  end

  def ziltaggable_params
    send "#{@ziltaggable_type}_params"
  end

  def photo_params
    params.require(:photo).permit(:image, :remote_image_url)
  end

  def post_params
    params.require(:post).permit(:title, :content, :published)
  end

  def ziltagging_params
    params.require(:ziltagging).permit(:x, :y)
  end
end
