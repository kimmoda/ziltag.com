require 'test_helper'

class Api::V1::Users::SessionsControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # {
  #   "id": 339078012,
  #   "email": "tonytonyjan@ziltag.com",
  #   "created_at": "2015-10-25T21:56:39.000+08:00",
  #   "updated_at": "2015-10-25T21:56:39.714+08:00",
  #   "avatar": {
  #     "url": "http://www.gravatar.com/avatar/43cb18a7b685ee9a320579fdf6d418ed",
  #     "thumb": {
  #       "url": "http://www.gravatar.com/avatar/43cb18a7b685ee9a320579fdf6d418ed"
  #     }
  #   },
  #   "username": "tonytonyjan",
  #   "cover": {
  #     "url": "/images/fallback/cover_1.jpg",
  #     "thumb": {
  #       "url": "/images/fallback/thumb_cover_1.jpg"
  #     },
  #     "default": {
  #       "url": "/images/fallback/default_cover_1.jpg"
  #     }
  #   }
  # }
  def test_sign_in
    post :create, format: :json, user: {login: users(:tony).email, password: 'password'}
    json = JSON.parse response.body
    assert_equal users(:tony).email, json['email']
  end

  def test_sign_out
    delete :destroy, format: :json
    assert_response 204
  end
end
