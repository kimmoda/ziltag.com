class Admin::ZiltaggingsController < AdminController
  before_action :set_admin_ziltagging, only: [:show, :edit, :update, :destroy]

  # GET /admin/ziltaggings
  def index
    @admin_ziltaggings = Admin::Ziltagging.includes(:photo, :ziltaggable).order('ziltaggings.id DESC').page(params[:page])
    @admin_ziltaggings = @admin_ziltaggings.where(photos: {source: params[:image_url]}) if params[:image_url]
  end

  # GET /admin/ziltaggings/1
  def show
  end

  # GET /admin/ziltaggings/new
  def new
    @admin_ziltagging = Admin::Ziltagging.new
  end

  # GET /admin/ziltaggings/1/edit
  def edit
  end

  # POST /admin/ziltaggings
  def create
    @admin_ziltagging = Admin::Ziltagging.new(admin_ziltagging_params)

    if @admin_ziltagging.save
      redirect_to @admin_ziltagging, notice: t('scaffold.created', model: Admin::Ziltagging.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/ziltaggings/1
  def update
    if @admin_ziltagging.update(admin_ziltagging_params)
      redirect_to @admin_ziltagging, notice: t('scaffold.updated', model: Admin::Ziltagging.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/ziltaggings/1
  def destroy
    @admin_ziltagging.destroy
    redirect_to admin_ziltaggings_url, notice: t('scaffold.destroied', model: Admin::Ziltagging.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_ziltagging
      @admin_ziltagging = Admin::Ziltagging.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_ziltagging_params
      params.require(:admin_ziltagging).permit(:ziltaggable_id, :ziltaggable_type, :photo_id, :x, :y)
    end
end
