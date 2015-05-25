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
    post :collect, post_id: posts(:tony).id
    @david.reload
    assert @david.collect?(posts(:tony))
    assert_response :success
  end

  test "should delete uncollect" do
    assert @tony.collect?(posts(:david))
    sign_in @tony
    delete :uncollect, post_id: posts(:david).id
    @tony.reload
    refute @tony.collect?(posts(:david))
    assert_response :success
  end

end
