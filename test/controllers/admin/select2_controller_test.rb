require 'test_helper'

class Admin::Select2ControllerTest < ActionController::TestCase
  test "should get query" do
    get :query, plural: :posts, q: '大兜'
    assert_equal [posts(:tony)], assigns(:posts)
    assert_response :success

    get :query, plural: :comments, q: '拉拉'
    assert_equal [comments(:tony), comments(:guest)].sort!, assigns(:comments).to_a.sort!
    assert_response :success
  end

end
