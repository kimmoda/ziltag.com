# frozen_string_literal: true
class Subscribe < Interactor2 #:nodoc:
  def initialize(user, ziltag)
    @user = user
    @ziltag = ziltag
  end

  def perform
    subscribe
    fail! @ziltag.errors.full_messages.first unless @ziltag.save
  end

  def subscribe
    return unless @ziltag.unsubscribers.include? @user.id
    @ziltag.unsubscribers.delete(@user.id)
  end
end
