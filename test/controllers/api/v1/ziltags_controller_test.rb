require 'test_helper'

class Api::V1::ZiltagsControllerTest < ActionController::TestCase
  def test_get_index
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me'
    assert_response :success
  end

  def test_get_index_without_href
    stub_request_for_image
    get :index, format: :json, src: 'http://webmock.me/jpeg'
    assert_response :success
  end

  def test_get_index_with_404
    stub_request_for_404
    get :index, format: :json, src: 'http://webmock.me/notfound'
    assert_response :bad_request
  end

  def test_get_index_with_non_image
    stub_request_for_html
    get :index, format: :json, src: 'http://webmock.me'
    assert_response :bad_request
  end

end
