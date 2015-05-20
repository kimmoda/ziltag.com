require 'test_helper'

class ZiltaggingsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: ziltaggings(:tony)
    assert_response :success

    sign_in(:user, users(:tony))
    get :show, id: ziltaggings(:tony)
    assert_response :success
  end

end
