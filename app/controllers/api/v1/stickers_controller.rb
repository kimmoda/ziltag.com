class Api::V1::StickersController < ApplicationController
  def index
    @stickers = Sticker.by_image_source(params[:source])
  end
end
