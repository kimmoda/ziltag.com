require 'test_helper'

class Api::V1::CommentsControllerTest < ActionController::TestCase
  def test_show
    get :show, format: :json, id: comments(:tony).id
    json = JSON.parse response.body
    assert_equal comments(:tony).id, json['id']
  end

  def test_create
    sign_in users(:tony)
    post :create, format: :json, comment: {content: 'hello', ziltag_id: ziltags(:tony).slug}
    json = JSON.parse response.body
    assert_equal 'hello', json['content']
  end

  def test_update
    sign_in users(:tony)
    patch :update, format: :json, id: comments(:tony).id, comment: {content: 'xxyy'}
    json = JSON.parse response.body
    assert_equal 'xxyy', json['content']
  end

  def test_destroy
    sign_in users(:tony)
    delete :destroy, format: :json, id: comments(:tony).id
    assert_response :no_content
  end

end
