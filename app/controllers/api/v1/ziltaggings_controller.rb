class Api::V1::ZiltaggingsController < ApiController
  before_action :set_ziltagging, only: :show
  before_action :set_user_ziltagging, only: %i[update destroy]

  def index
    @ziltaggings = Ziltagging.order('id DESC').page(params[:page])
    @ziltaggings = @ziltaggings.by_source(params[:source])
  end

  def create
    @ziltagging = current_user.ziltaggings.new(ziltagging_params)
    if @ziltagging.save
      render :show
    else
      render json: @ziltagging.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ziltagging.update(ziltagging_params)
      render :show
    else
      render json: @ziltagging.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ziltagging.destroy
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ziltagging
      @ziltagging = Ziltagging.find(params[:id])
    end

    def set_user_ziltagging
      @ziltagging = current_user.ziltaggings.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ziltagging_params
      params.require(:ziltagging).permit(:user_id, :title, :content, :published)
    end
end
