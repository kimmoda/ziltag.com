require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    Ziltagging.includes(post: :tags).import
  end

  test 'should get home' do
    get :home
    assert_response :success

    sign_in(:user, users(:tony))
    get :home
    assert_response :success
  end

end
