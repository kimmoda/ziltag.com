require 'test_helper'

class Admin::Select2Test < ActiveSupport::TestCase
  test '#query' do
    emails = Admin::Select2.query(Admin::User, :email, 'tony').pluck(:email)
    assert_equal %w[tonytonyjan@ziltag.com], emails

    emails = Admin::Select2.query(Admin::User, :email, 'ziltag').pluck(:email)
    assert_equal %w[tonytonyjan@ziltag.com david@ziltag.com].sort!, emails.sort!
  end
end
