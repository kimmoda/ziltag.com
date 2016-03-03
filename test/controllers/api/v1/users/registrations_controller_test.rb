require 'test_helper'

class Api::V1::Users::RegistrationsControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def test_sign_up
    post :create, format: 'json', user: {username: 'weihang', email: 'tonytonyjan@gmail.com', password: 'password', password_confirmation: 'password'}
    json = JSON.parse response.body
    assert_equal 'weihang', json['username']
    assert_equal 'tonytonyjan@gmail.com', json['email']
  end

  def test_sign_up_with_invalid_record
    post :create, format: 'json', user: {username: 'xx', email: 'tonytonyjan@gmail.com', password: 'password', password_confirmation: 'password'}
    json = JSON.parse response.body
    assert_equal String, json['error'].class
  end
end
