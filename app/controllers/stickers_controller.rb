class StickersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sticker, only: %i[update destroy]

  def create
    @sticker = current_user.stickers.new(sticker_params)
    if @sticker.save
      redirect_to photo_path(source: @sticker.photo.source, sticker_id: @sticker.id)
    else
      redirect_to request.referer
    end
  end

  def update
    if @sticker.update sticker_params
      redirect_to photo_path(source: @sticker.photo.source, sticker_id: @sticker.id)
    else
      redirect_to require.referer
    end
  end

  def destroy
    @sticker
    @sticker.destroy
    redirect_to photo_path(source: @sticker.photo.source)
  end

private

  def sticker_params
    params.require(:sticker).permit(:x, :y, :photo_id, :content)
  end

  def set_sticker
    @sticker = current_user.stickers.find params[:id]
  end

end
