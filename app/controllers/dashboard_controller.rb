# frozen_string_literal: true
class DashboardController < ApplicationController
  def index
    if request.path.start_with?('/dashboard') &&
       !request.path.start_with?('/dashboard/verify') &&
       !request.path.start_with?('/dashboard/password')
      authenticate_user!
    else
      track 'visit-home'
    end
    render layout: false
  end
end
