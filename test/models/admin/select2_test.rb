require 'test_helper'

class Admin::Select2Test < ActiveSupport::TestCase
  test 'query' do
    emails = Admin::Select2.query(Admin::User, :email, 'user1').pluck(:email)
    assert_equal ["user1@example.com"], emails
    titles = Admin::Select2.query(Admin::Photo, :title, '1').pluck(:title)
    assert_equal [
      "標題 1", "標題 10", "標題 11", "標題 12", "標題 13", "標題 14",
      "標題 15", "標題 16", "標題 17", "標題 18", "標題 19"
    ].sort!, titles.sort!
  end
end
