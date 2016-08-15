# frozen_string_literal: true
class Guest
  attr_accessor :email, :username, :url
  attr_reader :user, :box

  def initialize(email: nil, username: nil, url: nil)
    @email = email
    @username = username
    @url = url
    @user = ContentProvider.new(email: email, username: username, url: url)
    @box = Box.new(url: url)
  end

  def valid_email?
    @user.valid? || !@user.errors.include?(:email)
  end

  def valid_username?
    @user.valid? || !@user.errors.include?(:username)
  end

  def valid_url?
    @box.valid? || !@box.errors.include?(:url)
  end

  def create_user!
    User.transaction do
      @user.save!
      @user.box.update!(url: @box.url)
    end
    @user
  end
end
