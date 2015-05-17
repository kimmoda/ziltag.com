require 'test_helper'

class FollowingControllerTest < ActionController::TestCase
  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "should post follow" do
    @david, @tony = users(:david), users(:tony)
    refute @david.follow?(@tony)
    post :follow, follower_id: @david.id, leader_id: @tony.id
    assert @david.follow?(@tony)
    assert_response :success
  end

  test "should delete unfollow" do
    assert @tony.follow?(@david)
    delete :unfollow, follower_id: @tony.id, leader_id: @david.id
    refute @tony.follow?(@david)
    assert_response :success
  end

end
