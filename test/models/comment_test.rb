require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test '#avatar_url' do
    assert_equal 'http://localhost:3000/uploads/users/avatar/339078012/thumb_tony_avatar.jpg', comments(:tony).avatar_url
    assert_equal 'http://localhost:3000/images/fallback/tiny_guest.png', comments(:guest).avatar_url
  end
end
