require 'test_helper'

class Api::V1::ZiltagControllerTest < ActionController::TestCase
  test 'post ziltag' do
    sign_in(:user, users(:tony))
    post(:ziltag, {
      photo: {
        remote_image_url: 'http://tonytonyjan.net/images/site/avatar.png'
      },
      post: {
        title: 'Hello',
        content: 'World',
        published: true
      },
      ziltagging: {x: 12, y: 32},
      format: :json
    })
    assert_response :success
    json = JSON.parse response.body
    assert json['photo']['id'].present?
    assert json['post']['id'].present?
    assert json['ziltagging']['id'].present?
    assert_equal json['ziltagging']['post_id'], json['post']['id']
    assert_equal json['ziltagging']['photo_id'], json['photo']['id']
  end

  test 'post ziltag with failed' do
    sign_in(:user, users(:tony))
    post(:ziltag, {
      photo: {
        remote_image_url: 'http://tonytonyjan.net/images/site/avatar.png'
      },
      post: {
        content: 'World',
        published: true
      },
      ziltagging: {x: 12, y: 32},
      format: :json
    })
    assert_response :unprocessable_entity
    json = JSON.parse response.body
    assert json['post']['title'].present?
  end

end
