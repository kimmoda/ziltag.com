class Admin::ZiltaggingsController < ApplicationController
  def index
    @admin_ziltaggings = Ziltagging.order('id DESC').page(params[:page])
    @admin_ziltaggings = @admin_ziltaggings.joins(:photo).where(photos: {source: params[:image_url]}) if params[:image_url]
  end
end
