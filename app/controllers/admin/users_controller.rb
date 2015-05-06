class Admin::UsersController < AdminController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @admin_users = Admin::User.all.order('id DESC').page(params[:page])
    @admin_users = Admin::Select2.query(@admin_users, :email, params[:q])
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @admin_user = Admin::User.new(admin_user_params)

    if @admin_user.save
      redirect_to @admin_user, notice: t('scaffold.created', model: Admin::User.model_name.human)
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @admin_user.update(admin_user_params)
      redirect_to @admin_user, notice: t('scaffold.updated', model: Admin::User.model_name.human)
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @admin_user.destroy
    redirect_to admin_users_url, notice: t('scaffold.destroied', model: Admin::User.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_user_params
      params.require(:admin_user).permit(:email, :username, :avatar, :avatar_cache, :remove_avatar, :password)
    end
end
