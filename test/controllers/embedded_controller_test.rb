require 'test_helper'

class EmbeddedControllerTest < ActionController::TestCase
  test "should get ziltagging" do
    get :ziltagging, id: ziltaggings(:tony)
    assert_response :success

    sign_in(:user, users(:tony))
    get :ziltagging, id: ziltaggings(:tony)
    assert_response :success
  end

  test "should get photos" do
    get :photos, q: %w[http://localhost:3000/uploads/photos/image/1/tony.jpg http://localhost:3000/uploads/photos/image/3/tony.jpg], format: :json
    assert_response :success
    expected = [
      {"q"=>"http://localhost:3000/uploads/photos/image/1/tony.jpg", "ziltaggings"=>[{"x"=>20, "y"=>20, "link"=>"http://test.host/embedded/ziltagging/339078012"}]},
      {"q"=>"http://localhost:3000/uploads/photos/image/3/tony.jpg", "ziltaggings"=>[]}
    ]
    assert_equal expected, JSON.parse(response.body)
  end

end
