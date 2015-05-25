require 'test_helper'

class RedactorControllerTest < ActionController::TestCase
  test 'upload image' do
    post :images, file: fixture_file_upload('images/1.jpg', 'image/jpg')
    assert_response :success
    assert_equal "{\"filelink\":\"http://localhost:3000/uploads/photos/image/339078013/1.jpg\"}", response.body
  end
end
