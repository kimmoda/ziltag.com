require 'test_helper'

class Admin::Select2ControllerTest < ActionController::TestCase
  test "should get query" do
    get :query, plural: :posts, q: '大兜'
    assert_equal [posts(:tony)], assigns(:posts)
    assert_response :success

    get :query, plural: :posts, q: '顆顆'
    assert_equal [], assigns(:posts)
    assert_response :success
  end

end
