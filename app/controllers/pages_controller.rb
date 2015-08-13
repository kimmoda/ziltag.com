class PagesController < ApplicationController
  layout 'normal'

  def home
    @query = params[:q]
    @ziltaggings = Ziltagging.search(@query).records.page(params[:page]).per(10)
    if params[:scroll]
      render :partial => "/partials/post_article", collection: @ziltaggings, as: :ziltagging
    else
      @layout = 'sidebar'
      render layout: 'sidebar'
    end
  end
end
