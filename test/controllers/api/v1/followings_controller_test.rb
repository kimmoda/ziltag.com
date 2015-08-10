require 'test_helper'

class Api::V1::FollowingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test "follow" do
    refute @david.follow?(@tony)
    sign_in @david
    post :create, leader_id: @tony.id, format: :json  
    @david.reload
    assert @david.follow?(@tony)
    assert_response :success
  end

  test "unfollow" do
    assert @tony.follow?(@david)
    sign_in @tony
    delete :destroy, leader_id: @david.id, format: :json  
    @tony.reload
    refute @tony.follow?(@david)
    assert_response :success
  end

end
