# frozen_string_literal: true
class GetUserPermissions < Interactor2 #:nodoc:
  attr_reader :permissions

  def initialize(user, website)
    @user = user
    @website = website
  end

  def perform
    @permissions = if @website.restricted && @user != @website.user
                     []
                   else
                     ['create_ziltag']
                   end
  end
end
