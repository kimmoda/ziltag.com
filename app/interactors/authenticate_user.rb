# frozen_string_literal: true
class AuthenticateUser
  include Interactor

  def initialize(username_or_email, password)
    @username_or_email = username_or_email
    @password = password
  end

  def call
    user = User.find_for_database_authentication(sign_in: @username_or_email)
    if user && user.valid_password?(@password)
      context[:user] = user
    else
      fail! 'invalid sign in name or password'
    end
  end
end
