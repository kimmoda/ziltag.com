class DashboardController < ApplicationController
  def index
    if request.path.start_with?('/dashboard') && !request.path.start_with?('/dashboard/verify')
      authenticate_user!
    else
      track 'visit-home'
    end
    render layout: false
  end
end
