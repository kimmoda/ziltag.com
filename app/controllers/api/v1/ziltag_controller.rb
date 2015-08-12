class Api::V1::ZiltagController < ApiController
  before_action :authenticate_user!, only: :ziltag

  # POST /api/v1/ziltag
  def ziltag
    @ziltag = Abstract::Ziltag.new({
      photo: Photo.find_or_create_by_url!(photo_params),
      post: current_user.posts.new(post_params),
      ziltagging: Ziltagging.new(ziltagging_params)
    })
    @ziltag.save!
  rescue
    render json: {
      photo: @ziltag.photo.errors,
      post: @ziltag.post.errors,
      ziltagging: @ziltag.ziltagging.errors
    }, status: :unprocessable_entity
  end

private

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
