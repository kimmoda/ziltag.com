class Api::V1::RedactorController < ApiController
  def upload
    @photo = Photo.new image: params.require(:file)
    if @photo.save
      render template: 'api/v1/photos/show'
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end
end
