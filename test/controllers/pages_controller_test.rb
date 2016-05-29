require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  class SignInContext < self
    def setup
      sign_in users(:tony)
    end
  end
end