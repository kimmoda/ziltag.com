class PagesController < ApplicationController
  layout 'normal'

  def home
    if @query = params[:q].presence
      @ziltaggings = Ziltagging.search(@query).records
    else
      @ziltaggings = Ziltagging.all
    end

    @ziltaggings = @ziltaggings.order('id DESC').page(params[:page]).per(10)

    if params[:scroll]
      render :partial => "/partials/post_article", collection: @ziltaggings, as: :ziltagging
    else
      @layout = 'sidebar'
      render layout: 'sidebar'
    end
  end

  def landing
    render layout: 'landing'
  end
end
