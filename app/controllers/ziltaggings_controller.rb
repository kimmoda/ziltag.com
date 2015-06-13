class ZiltaggingsController < ApplicationController
  before_action :set_ziltagging
  layout 'sidebar'.freeze

  def show
    @other_ziltaggings = @ziltagging.other_ziltaggings
  end

  # TODO: 防止非作者篡改
  # PUT /ziltaggings/:id.json
  def update
    @ziltagging.update! ziltagging_params
    head :ok
  end

  # TODO: 防止非作者篡改
  # DELETE /ziltaggings/:id.json
  def destroy
    @ziltagging.destroy
    head :ok
  end

private

  def set_ziltagging
    @ziltagging = Ziltagging.find params[:id]
  end

  def ziltagging_params
    params.require(:ziltagging).permit(:x, :y)
  end

end
