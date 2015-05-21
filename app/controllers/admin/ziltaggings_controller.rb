class Admin::ZiltaggingsController < ApplicationController
  def index
    @admin_ziltaggings = Ziltagging.includes(:photo, :post).order('ziltaggings.id DESC').page(params[:page])
    @admin_ziltaggings = @admin_ziltaggings.where(photos: {source: params[:image_url]}) if params[:image_url]
  end
end
