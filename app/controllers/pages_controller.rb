class PagesController < ApplicationController
  layout 'sidebar'.freeze

  def home
    @ziltaggings = Ziltagging.includes(:photo, post: :user).order('id DESC').page(params[:page]).per(10)
  end
end
