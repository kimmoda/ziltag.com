# frozen_string_literal: true
class DashboardController < ApplicationController
  before_action :check_referer!, :auth, :check_mobile!, only: :index

  def index
    render layout: false
  end

  def redirect
    render layout: false
  end

  private

  def check_referer!
    if request.path.start_with?('/dashboard/account') &&
       request.referer &&
       URI(request.referer).path =~ %r{^/ziltag_maps/(\w+)/?} &&
       Photo.select(:natural_id, :website_id).joins(:website).find_by(natural_id: $1, websites: {user_id: demo_user.id})
      redirect_to dashboard_redirect_path
    end
  end

  def auth
    if request.path.start_with?('/dashboard') &&
       !request.path.start_with?('/dashboard/verify') &&
       !request.path.start_with?('/dashboard/password')
      authenticate_user!
    end
  end

  def check_mobile!
    if request.path.start_with?('/dashboard/verify') && mobile?
      redirect_to "/m/password?#{request.query_string}"
    end
  end
end
