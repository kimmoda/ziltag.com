require 'test_helper'

class Api::V1::ZiltagsControllerTest < ActionController::TestCase
  def test_get_index
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: boxes(:tony).token, width: 200, height: 200
    assert_response :success
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: boxes(:blogger).token, width: 200, height: 200
    assert_response 400
  end

  def test_without_widht_and_height
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: boxes(:tony).token
    json = JSON.parse response.body
    assert_equal({"errors"=>{"width"=>["can't be blank"], "height"=>["can't be blank"]}}, json)
  end

  def test_existed_photo
    stub_request_for_image
    photo = photos(:one)
    get :index, format: :json, src: photo.source, href: photo.href, token: photo.token, width: 200, height: 200
    assert_response :success
    assert_equal photo.slug, JSON.parse(response.body)['map']
    assert_equal [{'id' => 'abcdef','x' => 0.5,'y' => 0.5,'usr' => 'tonytonyjan','preview' => 'Hello'}], JSON.parse(response.body)['ziltags']
  end

  def test_show
    get :show, format: :json, id: ziltags(:tony).slug
    json = JSON.parse response.body
    assert_equal ziltags(:tony).slug, json['slug']
  end


  def test_create
    sign_in users(:tony)
    post :create, format: :json, ziltag: {x: 0.5, y: 0.5, content: 'hello', photo_id: photos(:one).id}
    json = JSON.parse response.body
    assert_equal 'hello', json['content']
    assert_equal users(:tony).id, json['user']['id']
  end

  def test_update
    sign_in users(:tony)
    patch :update, format: :json, id: ziltags(:tony).slug, ziltag: {x: 0.1, y: 0.1}
    json = JSON.parse response.body
    assert_equal '0.1', json['x']
    assert_equal '0.1', json['y']
  end

  def test_destroy
    sign_in users(:tony)
    delete :destroy, format: :json, id: ziltags(:tony).slug
    assert_response :no_content
  end
end
