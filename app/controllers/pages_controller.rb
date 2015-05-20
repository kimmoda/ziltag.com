class PagesController < ApplicationController
  def home
    @ziltaggings = Ziltagging.includes(:photo, post: :user).order('id DESC').limit(10)
  end
end
