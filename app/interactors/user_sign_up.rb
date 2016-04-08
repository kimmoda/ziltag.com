class UserSignUp
  include Interactor

  def initialize username, email
    @username, @email = username, email
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