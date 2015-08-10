require 'test_helper'

class Api::V1::CollectingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "should post collect" do
    refute @david.collect?(posts(:tony))
    sign_in @david
    post :create, id: posts(:tony).id, type: 'Post', format: :json
    @david.reload
    assert @david.collect?(posts(:tony))
    assert_response :success
  end

  test "should delete uncollect" do
    assert @tony.collect?(posts(:david))
    sign_in @tony
    delete :destroy, id: posts(:david).id, type: 'Post', format: :json
    @tony.reload
    refute @tony.collect?(posts(:david))
    assert_response :success
  end

  test "white list" do
    sign_in @david
    post :create, id: posts(:tony).id, type: 'Post', format: :json
    assert_response :success
    post :create, id: users(:tony).id, type: 'User', format: :json
    assert_response :bad_request
  end

end
