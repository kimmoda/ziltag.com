class UpgradeController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_partner

  def show
  end

  def upgrade
    if params[:platform] == 'general' || params[:blog_id].present?
      url = ServiceURLConverter.convert(params)
      @guest = Guest.new(url: url)
      if @guest.valid_url?
        current_user.update_attribute :type, 'ContentProvider'
        current_user.box.update url: url
        redirect_to install_path
      else
        @error = @guest.box.errors[:url].first
        render :show
      end
    else
      @error = 'Blog ID can not be blank'
      render :show
    end
  end

  private

  def redirect_partner
    redirect_to install_path if current_user.content_provider?
  end
end
