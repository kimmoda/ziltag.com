require 'test_helper'

class ZiltaggingsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: ziltaggings(:tony)
    assert_response :success

    sign_in(:user, users(:tony))
    get :show, id: ziltaggings(:tony)
    assert_response :success
  end

  test "should update" do
    ziltagging = ziltaggings(:tony)
    put :update, id: ziltagging.id, ziltagging: {x: 11, y: 23}
    assert_response :success
    ziltagging.reload
    assert_equal 11, ziltagging.x
    assert_equal 23, ziltagging.y
  end

  test "should destroy" do
    ziltagging = ziltaggings(:tony)
    delete :destroy, id: ziltagging.id
    assert_response :success
    refute Ziltagging.exists? id: ziltagging.id
  end

end
