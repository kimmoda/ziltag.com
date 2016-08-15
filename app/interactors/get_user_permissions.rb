# frozen_string_literal: true
class GetUserPermissions < Interactor2 #:nodoc:
  attr_reader :permissions

  def initialize(user, box)
    @user = user
    @box = box
  end

  def perform
    @permissions = if @box.restricted && @user != @box.user
                     []
                   else
                     ['create_ziltag']
                   end
  end
end
