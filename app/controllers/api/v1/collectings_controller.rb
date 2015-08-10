class Api::V1::CollectingsController < ApiController
  WHITE_TYPE_LIST = %w[Post]
  before_action :set_collectable

  def create
    current_user.collect! @collectable
    head :ok
  end

  def destroy
    current_user.uncollect! @collectable
    head :ok
  end

private

  def set_collectable
    if params[:id].present? && WHITE_TYPE_LIST.include?(params[:type])
      @collectable = params[:type].constantize.find(params[:id])
    else
      head :bad_request
    end
  end

end
