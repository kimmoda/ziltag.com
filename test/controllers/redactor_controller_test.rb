require 'test_helper'

class RedactorControllerTest < ActionController::TestCase
  test 'upload image' do
    post :images, file: fixture_file_upload('images/1.jpg', 'image/jpg')
    assert_response :success
    json = JSON.parse response.body
    assert_match %r{http://localhost:3000/uploads/photos/image/\d+/1.jpg}, json['filelink']
  end
end
