require 'test_helper'

class CollectingControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "should post collect" do
    refute @david.collect?(posts(:tony))
    sign_in @david
    post :collect, id: posts(:tony).id, type: :Post
    @david.reload
    assert @david.collect?(posts(:tony))
    assert_response :success
  end

  test "should delete uncollect" do
    assert @tony.collect?(posts(:david))
    sign_in @tony
    delete :uncollect, id: posts(:david).id, type: :Post
    @tony.reload
    refute @tony.collect?(posts(:david))
    assert_response :success
  end

  test "white list" do
    sign_in @david
    post :collect, id: posts(:tony).id, type: :Post
    assert_response :success
    post :collect, id: users(:tony).id, type: :User
    assert_response :bad_request
  end

end
