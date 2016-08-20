# frozen_string_literal: true

# sign up as nromal user
class UserSignUp < Interactor2
  attr_reader :user

  def initialize(username, email)
    @username = username
    @email = email
  end

  def perform
    @user = User.new username: @username, email: @email
    if @user.save
      SendWelcomeEmailJob.perform_later(user)
      SubscribeNewsletterJob.perform_later(user)
      SendProductFeedbackToGeneralUserJob.perform_later(user)
    else
      fail! user.errors.full_messages.first
    end
  end
end
