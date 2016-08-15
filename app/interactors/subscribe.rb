# frozen_string_literal: true
class Subscribe
  include Interactor

  def initialize(user, ziltag)
    @user = user
    @ziltag = ziltag
  end

  def call
    subscribe
    fail! @ziltag.errors.full_messages.first unless @ziltag.save
  end

  def subscribe
    return unless @ziltag.unsubscribers.include? @user.id
    @ziltag.unsubscribers.delete(@user.id)
  end
end
