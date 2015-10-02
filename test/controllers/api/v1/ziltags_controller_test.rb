require 'test_helper'

class Api::V1::ZiltagsControllerTest < ActionController::TestCase
  def test_get_index
    get :index, format: :json, src: 'https://drscdn.500px.org/photo/123614547/m=2048/f7e91fdd7a9e5a1df20f0e714cad96ce', href: 'https://500px.com/photo/123614547/encounter-with-colors-by-rahul-tripathi'
    assert_response :success
  end

  def test_get_index_without_href
    get :index, format: :json, src: 'https://drscdn.500px.org/photo/123614547/m=2048/f7e91fdd7a9e5a1df20f0e714cad96ce'
    assert_response :success
  end

  def test_get_index_with_404
    get :index, format: :json, src: 'http://google.com/notfound'
    assert_response :bad_request
  end

  def test_get_index_with_non_image
    get :index, format: :json, src: 'http://google.com'
    assert_response :bad_request
  end

end
