class CollectingController < ApplicationController
  WHITE_TYPE_LIST = %w[Post]

  before_action :authenticate_user!, :set_collectable

  def collect
    current_user.collect! @collectable
    head :ok
  end

  def uncollect
    current_user.uncollect! @collectable
    head :ok
  end

private

  def set_collectable
    if params[:id] && WHITE_TYPE_LIST.include?(params[:type])
      @collectable = params[:type].constantize.find(params[:id])
    else
      head :bad_request
    end
  end

end
