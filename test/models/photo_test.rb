require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @token = boxes(:tony).token
    @blogger_token = boxes(:blogger).token
    @localhost_token = boxes(:localhost).token
  end

  def test_find_or_create_by_source_and_href_and_token!
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', 'tonytonyjan', width: 200, height: 200
    assert photo.persisted?
    assert_equal boxes(:tony), photo.box
  end

  def test_same_domain
    stub_request_for_image
    p1 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me/aaa', @token, width: 200, height: 200
    p2 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me/bbb', @token, width: 200, height: 200
    assert_equal p1, p2
  end

  def test_permission
    assert_raises do
      Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.tw/bbb', @token, width: 200, height: 200
    end
  end

  def test_blogspot
    stub_request_for_image
    p1 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://tony.blogspot.tw/aaa', @blogger_token, width: 200, height: 200
    p2 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://tony.blogspot.jp/bbb', @blogger_token, width: 200, height: 200
    assert_equal p1, p2
  end

  def test_find_existed_image
    stub_request_for_image
    p1 = photos(:one)
    p2 = Photo.find_or_create_by_source_and_href_and_token! p1.source, p1.href, @localhost_token, width: 200, height: 200
    assert_equal p1, p2
  end

  def test_duplicated_source
    stub_request_for_image
    p1 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', @token, width: 200, height: 200
    p2 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', @token, width: 200, height: 200
    assert_equal p1, p2
  end
end
