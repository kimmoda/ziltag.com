require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success

    sign_in(:user, users(:tony))
    get :index
    assert_response :success
  end

end
