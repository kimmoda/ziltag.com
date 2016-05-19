class DashboardController < ApplicationController
  def index
    authenticate_user! if request.path.start_with? '/dashboard'
    render layout: false
  end
end
