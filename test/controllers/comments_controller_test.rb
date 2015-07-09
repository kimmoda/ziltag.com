require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, photo_id: comments(:tony).id, format: :json
    assert_response :success
  end

  test "should get show" do
    get :show, id: comments(:tony), format: :json
    assert_response :success
  end

end
