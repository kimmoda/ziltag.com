# frozen_string_literal: true
class Unsubscribe < Interactor2 #:nodoc:
  def self.verify(token)
    Rails.application.message_verifier(:unsubscribe).verify(token)
  end

  def initialize(user, ziltag)
    @user = user
    @ziltag = ziltag
  end

  def token
    Rails.application.message_verifier(:unsubscribe).generate([@user.id, @ziltag.id])
  end

  def perform
    return if @ziltag.unsubscribers.include? @user.id
    @ziltag.unsubscribers << @user.id
    fail! @ziltag.errors.full_messages.first unless @ziltag.save
  end
end
