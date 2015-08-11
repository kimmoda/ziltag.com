class Api::V1::RedactorController < ApiController
  def upload
    @photo = Photo.new image: params.require(:file)
    if @photo.save
      render json: {filelink: @photo.image_url}
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end
end
