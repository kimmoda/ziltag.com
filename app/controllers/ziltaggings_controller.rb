class ZiltaggingsController < ApplicationController
  def show
    @ziltagging = Ziltagging.find params[:id]
    @other_ziltaggings = @ziltagging.other_ziltaggings
  end
end
