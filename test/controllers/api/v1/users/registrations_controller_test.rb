require 'test_helper'

class Api::V1::Users::RegistrationsControllerTest < ActionController::TestCase
  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  # {
  #   "id": 339078013,
  #   "email": "tonytonyjan@gmail.com",
  #   "created_at": "2015-10-25T22:26:27.095+08:00",
  #   "updated_at": "2015-10-25T22:26:27.708+08:00",
  #   "avatar": {
  #     "url": "http://www.gravatar.com/avatar/2a01ae9942939ee2b3954a6727d2bb92",
  #     "thumb": {
  #       "url": "http://www.gravatar.com/avatar/2a01ae9942939ee2b3954a6727d2bb92"
  #     }
  #   },
  #   "username": "weihang",
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
  def test_sign_up
    post :create, format: 'json', user: {username: 'weihang', email: 'tonytonyjan@gmail.com', password: 'password', password_confirmation: 'password'}
    json = JSON.parse response.body
    assert_equal 'weihang', json['username']
    assert_equal 'tonytonyjan@gmail.com', json['email']
  end
end
