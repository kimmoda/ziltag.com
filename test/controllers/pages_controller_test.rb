require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home
    assert_response :success

    sign_in users(:tony)
    get :home
    assert_response :success
  end
end
