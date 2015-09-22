require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def test_get_home
    get :home
    assert_response :success
  end

  class SignInContext < self
    def setup
      sign_in users(:tony)
    end
  end
end