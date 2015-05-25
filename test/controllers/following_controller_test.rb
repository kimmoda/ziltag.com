require 'test_helper'

class FollowingControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "should post follow" do
    refute @david.follow?(@tony)
    sign_in @david
    post :follow, leader_id: @tony.id
    @david.reload
    assert @david.follow?(@tony)
    assert_response :success
  end

  test "should delete unfollow" do
    assert @tony.follow?(@david)
    sign_in @tony
    delete :unfollow, leader_id: @david.id
    @tony.reload
    refute @tony.follow?(@david)
    assert_response :success
  end

end
