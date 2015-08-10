require 'test_helper'

class Api::V1::SessionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  test '#create' do
    post :create, login: 'tonytonyjan', password: 'password', format: :json
    assert_response :success
    json = JSON.parse response.body
    expected = {"id"=>339078012, "email"=>"tonytonyjan@ziltag.com", "username"=>"tonytonyjan", "avatar"=>{"origin"=>"http://localhost:3000/uploads/users/avatar/339078012/tony_avatar.jpg", "thumb"=>"http://localhost:3000/uploads/users/avatar/339078012/thumb_tony_avatar.jpg"}, "cover"=>{"origin"=>"/images/fallback/cover_1.jpg", "default"=>"/images/fallback/default_cover_1.jpg", "thumb"=>"/images/fallback/thumb_cover_1.jpg"}}
    assert_equal(expected, json)
  end

  test '#destroy' do
    sign_in users(:tony)
    delete :destroy, format: :json
  end

end
