class ZiltagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ziltag, only: %i[update destroy]

  def create
    @ziltag = current_user.ziltags.new(ziltag_params)
    if @ziltag.save
      redirect_to photo_path(source: @ziltag.photo.source, ziltag_id: @ziltag.id)
    else
      redirect_to request.referer
    end
  end

  def update
    if @ziltag.update ziltag_params
      redirect_to photo_path(source: @ziltag.photo.source, ziltag_id: @ziltag.id)
    else
      redirect_to require.referer
    end
  end

  def destroy
    @ziltag
    @ziltag.destroy
    redirect_to photo_path(source: @ziltag.photo.source)
  end

private

  def ziltag_params
    params.require(:ziltag).permit(:x, :y, :photo_id, :content)
  end

  def set_ziltag
    @ziltag = current_user.ziltags.find params[:id]
  end

end
