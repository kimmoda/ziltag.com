class PagesController < ApplicationController
  layout 'sidebar'.freeze

  def home
    @ziltaggings = Ziltagging.includes(:photo, post: :user).where(posts: {published: true}).order('ziltaggings.id DESC').page(params[:page]).per(10)
    if params[:scroll]
      render :partial => "/partials/post_article", collection: @ziltaggings, as: :ziltagging
    end
  end

end
