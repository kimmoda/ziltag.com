class PagesController < ApplicationController
  layout 'normal'

  def home
    @ziltaggings = Ziltagging.includes(:photo, post: :user).where(posts: {published: true}).order('ziltaggings.id DESC').page(params[:page]).per(10)
    if params[:scroll]
      render :partial => "/partials/post_article", collection: @ziltaggings, as: :ziltagging
    else
      @layout = 'sidebar'
      render layout: 'sidebar'
    end
  end
end
