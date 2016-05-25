class PartnerSignUp
  include Interactor

  def initialize username, email, url
    @username, @email, @url = username, email, url
    @user = ContentProvider.new username: @username, email: @email
    @box = Box.new url: url, user: @user
  end

  def call
    ActiveRecord::Base.transaction do
      if @user.save && @box.save
        context[:user] = @user
        context[:box] = @box
      else
        raise ActiveRecord::Rollback
      end
    end
    error = @user.errors.full_messages.first || @box.errors.full_messages.first
    fail! error if error
  end
end