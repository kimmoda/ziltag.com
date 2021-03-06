# frozen_string_literal: true
require 'test_helper'

class Api::V1::ZiltagsControllerTest < ActionController::TestCase
  def test_get_index
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: websites(:tony).token, width: 200, height: 200
    assert_response :success
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: websites(:blogger).token, width: 200, height: 200
    assert_response 200
  end

  def test_without_widht_and_height
    skip
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: websites(:tony).token
    json = JSON.parse response.body
    assert json['error']
  end

  def test_existed_photo
    stub_request_for_image
    photo = photos(:one)
    get :index, format: :json, src: photo.source, href: photo.href, token: photo.token, width: 200, height: 200
    assert_response :success
    assert_equal photo.natural_id, JSON.parse(response.body)['id']
  end

  def test_show
    get :show, format: :json, id: ziltags(:tony).natural_id
    json = JSON.parse response.body
    assert_equal ziltags(:tony).natural_id, json['id']
  end

  def test_create
    sign_in users(:tony)
    post :create, format: :json, ziltag: { x: 0.5, y: 0.5, content: 'hello', map_id: photos(:one).natural_id }
    json = JSON.parse response.body
    assert_equal 'hello', json['content']
    assert_equal users(:tony).username, json['usr']['name']
  end

  def test_update
    sign_in users(:tony)
    patch :update, format: :json, id: ziltags(:tony).natural_id, ziltag: { content: 'blabla' }
    json = JSON.parse response.body
    assert_equal 'blabla', json['content']
  end

  def test_destroy
    sign_in users(:tony)
    delete :destroy, format: :json, id: ziltags(:tony).natural_id
    assert_response :no_content
  end
end
