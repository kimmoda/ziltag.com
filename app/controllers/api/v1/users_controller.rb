class Api::V1::UsersController < ApiController
  before_action :set_user

  def show
  end

  def update
    # TODO
  end

private

  def set_user
    @user = params[:id] == 'me' ? current_user : User.find(params[:id])
  end

end