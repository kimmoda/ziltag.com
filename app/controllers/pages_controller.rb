class PagesController < ApplicationController
  def home
    @ziltaggings = Ziltagging.includes(post: :user).order('id DESC').limit(10)
  end
end
