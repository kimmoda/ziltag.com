class Admin::ZiltaggingsController < ApplicationController
  def index
    @admin_ziltaggings = Ziltagging.all.order('id DESC').page(params[:page])
    @admin_ziltaggings = @admin_ziltaggings.where(image_url: params[:image_url]) if params[:image_url]
  end
end
