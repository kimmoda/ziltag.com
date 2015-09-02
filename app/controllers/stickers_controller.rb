class StickersController < ApplicationController
  before_action :authenticate_user!

  def create
    @sticker = current_user.stickers.new(sticker_params)
    if @sticker.save
      redirect_to photo_path(source: @sticker.photo.source, sticker_id: @sticker.id)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @sticker = current_user.stickers.find params[:id]
    @sticker.destroy
    redirect_to photo_path(source: @sticker.photo.source)
  end

private

  def sticker_params
    params.require(:sticker).permit(:x, :y, :photo_id, :content)
  end
end
