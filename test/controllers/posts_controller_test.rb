require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should create post" do
    sign_in users(:tony)
    post :create, format: :json, post: {
      title: '謝謝你',
      content: '<p>九五二七</p>'
    }
    assert_response :success
  end

end
