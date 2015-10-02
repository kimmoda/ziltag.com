require 'test_helper'

class Api::V1::ZiltagsControllerTest < ActionController::TestCase
  def setup
    stub_request(:get, 'webmock.me')
      .to_return(body: '<h1>Hello World</h1>')

    stub_request(:get, 'webmock.me/notfound').to_return(status: 404)

    stub_request(:get, 'webmock.me/jpeg')
      .to_return(
        body: File.new(Rails.root.join('test', 'fixtures', 'images', '1.jpg')),
        status: 200,
        headers: {'Content-Type' => 'image/jpeg'}
      )
  end

  def test_get_index
    get :index, format: :json, src: 'http://webmock.me/jpeg', href: 'http://webmock.me'
    assert_response :success
  end

  def test_get_index_without_href
    get :index, format: :json, src: 'http://webmock.me/jpeg'
    assert_response :success
  end

  def test_get_index_with_404
    get :index, format: :json, src: 'http://webmock.me/notfound'
    assert_response :bad_request
  end

  def test_get_index_with_non_image
    get :index, format: :json, src: 'http://webmock.me'
    assert_response :bad_request
  end

end
