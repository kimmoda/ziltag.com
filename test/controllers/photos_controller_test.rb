require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  def test_get_show
    ziltag = ziltags(:tony)
    get :show, slug: ziltag.photo, ziltag_slug: ziltag
    assert_response :success
  end

  class SignInContext < self
    def setup
      sign_in users(:tony)
    end
  end
end
