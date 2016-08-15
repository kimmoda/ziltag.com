# frozen_string_literal: true
class VerifyUser
  include Interactor

  def initialize(token, password, password_confirmation)
    @token = token
    @password = password
    @password_confirmation = password_confirmation
  end

  def call
    fail! 'Token can not be nil' if @token.nil?
    user = User.find_first_by_auth_conditions(confirmation_token: @token)
    fail! 'Can not find user by the given token' if user.nil?
    fail! 'The user has been verified' if user.confirmed?
    user.define_singleton_method(:password_required?) { true }
    if user.update password: @password, password_confirmation: @password_confirmation
      user.confirm
      user.comments.each do |comment|
        SendCommentNotificationJob.perform_later(comment)
      end
      context[:user] = user
    else
      fail! user.errors.full_messages.first
    end
  end
end
