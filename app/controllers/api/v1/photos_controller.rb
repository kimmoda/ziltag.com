# frozen_string_literal: true
class Api::V1::PhotosController < ApiController
  def show
    @photo = Photo.find_by slug: params[:id]
    render 'api/v1/ziltags/index'
  end
end
