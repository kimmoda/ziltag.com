# frozen_string_literal: true

# sign up as nromal user
class UserSignUp
  include Interactor

  def initialize(username, email)
    @username = username
    @email = email
  end

  def call
    user = User.new username: @username, email: @email
    if user.save
      context[:user] = user
    else
      fail! user.errors.full_messages.first
    end
  end
end
