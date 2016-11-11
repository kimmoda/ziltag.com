# frozen_string_literal: true
class DashboardController < ApplicationController
  def index
    if request.path.start_with?('/dashboard') &&
       !request.path.start_with?('/dashboard/verify') &&
       !request.path.start_with?('/dashboard/password')
      authenticate_user!
    end
    if request.path.start_with?('/dashboard/verify') && mobile?
      redirect_to "/m/password?#{request.query_string}"
    else
      render layout: false
    end
  end
end
