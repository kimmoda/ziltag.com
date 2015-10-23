class ZiltagsController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_ziltag, only: %i[update destroy]

  def create
    @ziltag = current_user.ziltags.new(ziltag_params)
    if @ziltag.save
      flash.notice = 'The zitlag will be pending until you finish account confirmation.' unless current_user.confirmed?
      redirect_to photo_path(@ziltag.photo, @ziltag)
    else
      redirect_to request.referer
    end
  end

  def update
    if @ziltag.update ziltag_params
      redirect_to photo_path(@ziltag.photo, @ziltag)
    else
      redirect_to require.referer
    end
  end

  def destroy
    @ziltag.destroy
    redirect_to photo_path(@ziltag.photo)
  end

private

  def ziltag_params
    params.require(:ziltag).permit(:x, :y, :photo_id, :content)
  end

  def set_ziltag
    @ziltag = current_user.ziltags.find_by! slug: params[:id]
  end

end
