# frozen_string_literal: true
require 'test_helper'

class Api::V1::Users::SessionsControllerTest < ActionController::TestCase
  def setup
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def test_sign_in
    post :create, format: :json, user: { sign_in: users(:tony).email, password: 'password' }
    json = JSON.parse response.body
    assert_equal users(:tony).email, json['email']
  end

  def test_sign_out
    get :destroy, format: :json
    assert_response 204
  end
end
