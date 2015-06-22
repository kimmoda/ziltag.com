class UsersController < ApplicationController
  layout "sidebar"
  before_action :set_user

  def show
    @ziltaggings = @user.ziltaggings
  end

  def collecting
    @posts = @user.collected_posts
  end

  def following
    @users = @user.leaders
  end

  def leading
    @users = @user.followers
    render :following
  end

private

  def set_user
    @user = User.find_by username: params[:id]
  end
end
