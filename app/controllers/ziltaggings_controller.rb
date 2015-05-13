class ZiltaggingsController < ApplicationController
  def show
    @ziltagging = Ziltagging.find params[:id]
    @other_ziltaggings = Ziltagging.where(image_url: @ziltagging.image_url).where.not(id: params[:id])
  end
end
