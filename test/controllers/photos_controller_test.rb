require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success

    sign_in(:user, users(:tony))
    get :index
    assert_response :success
  end

  test "should create image" do
    sign_in(:user, users(:tony))
    post :create,
      format: :json,
      photo: {image: fixture_file_upload('/images/1.jpg', 'image/jpeg', :binary)}
    assert_response :success
    assert JSON.parse(response.body).key?('id')
  end

end
