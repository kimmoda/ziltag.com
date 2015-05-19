require 'test_helper'

class FollowingControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "should post follow" do
    @david, @tony = users(:david), users(:tony)
    refute @david.follow?(@tony)
    sign_in @david
    post :follow, leader_id: @tony.id
    assert @david.follow?(@tony)
    assert_response :success
  end

  test "should delete unfollow" do
    assert @tony.follow?(@david)
    sign_in @tony
    delete :unfollow, leader_id: @david.id
    refute @tony.follow?(@david)
    assert_response :success
  end

end
