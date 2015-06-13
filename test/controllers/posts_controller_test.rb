require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test "should create post" do
    sign_in users(:tony)
    post :create, format: :json, post: {
      title: '謝謝你',
      content: '<p>九五二七</p>',
      ziltaggings_attributes: {
        '0' => {x: 123, y: 321, photo_id: photos(:tony).id}
      }
    }
    assert_response :success
    expected = {"id"=>339078013, "ziltaggings"=>[{"id"=>339078013, "x"=>123, "y"=>321}]}
    assert_equal expected, JSON.parse(response.body)
  end

end
