require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  def test_create_user!
    guest = Guest.new email: 'hello@world.com', username: 'hellworld', url: 'tonytonyjan.net'
    user = guest.create_user!
  end

  def test_error
    Guest.new(email: 'hello', username: 'hellworld', url: 'tonytonyjan.net').create_user!
  rescue ActiveRecord::RecordInvalid
    assert $!.record.errors.key? :email
  end

  def test_valid_email?
    assert Guest.new(email: 'hello@ziltag.com', username: 'hellworld', url: 'tonytonyjan.net').valid_email?
    assert Guest.new(email: 'hello@ziltag.com', username: 'xx', url: 'tonytonyjan.net').valid_email?
    refute Guest.new(email: 'hello', username: 'hellworld', url: 'tonytonyjan.net').valid_email?
  end

  def test_valid_username?
    assert Guest.new(email: 'hello@ziltag.com', username: 'hellworld', url: 'tonytonyjan.net').valid_username?
    assert Guest.new(email: 'hello', username: 'hellworld', url: 'tonytonyjan.net').valid_username?
    refute Guest.new(email: 'hello@ziltag.com', username: 'asdf', url: 'tonytonyjan.net').valid_username?
  end

  def test_valid_url?
    assert Guest.new(email: 'hello@ziltag.com', username: 'hellworld', url: 'tonytonyjan.net').valid_url?
    assert Guest.new(email: 'hello@ziltag.com', username: 'xx', url: 'tonytonyjan.net').valid_url?
    refute Guest.new(email: 'hello@ziltag.com', username: 'hellworld', url: 'tony').valid_url?
  end
end
