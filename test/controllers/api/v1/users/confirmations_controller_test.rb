require 'test_helper'

class Api::V1::Users::ConfirmationsControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def test_resend_confirmation
    post :resend, format: :json, email: users(:unconfirmed).email
    json = JSON.parse response.body
    assert_equal({}, json)
    assert_response :success
  end

  def test_resend_confirmation_with_confirmed_user
    post :resend, format: :json, email: users(:tony).email
    json = JSON.parse response.body
    assert_response :success
  end

  def test_resend_confirmation_without_email_parameter
    sign_in(users(:tony))
    post :resend, format: :json
    json = JSON.parse response.body
    assert_equal({}, json)
    assert_response :success
  end
end
