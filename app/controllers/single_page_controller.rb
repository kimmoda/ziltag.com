class SinglePageController < ApplicationController
  before_action :authenticate_user!, only: %i[install update_user]
  def install
    @user = current_user
  end

  # PUT /me
  def update_current_user
    @user = current_user
    if @user.update params.require(:user).permit(:username)
      redirect_to install_path, notice: 'updated'
    else
      flash.now[:alert] = 'Please check your input value.'
      render :install
    end
  end
end
