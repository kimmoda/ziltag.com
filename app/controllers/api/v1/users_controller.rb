class Api::V1::UsersController < ApplicationController
  def me
    if @user = current_user
      render :show
    else
      head 401
    end
  end
end
