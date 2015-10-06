require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def test_find_or_create_by_source_and_href_and_token!
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', 'tonytonyjan'
    assert photo.persisted?
    assert_equal boxes(:tony), photo.box
  end

  def test_find_existed_image
    stub_request_for_image
    p1 = photos(:one)
    p2 = Photo.find_or_create_by_source_and_href_and_token! p1.source, p1.href
    assert_equal p1, p2
    p3 = Photo.find_or_create_by_source_and_href_and_token! p1.source, 'tonytonyjan'
    refute_equal p1, p3
  end

  def test_without_token
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me'
    assert photo.persisted?
    assert_equal nil, photo.box
  end

  def test_without_href_and_token
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg'
    assert photo.persisted?
    assert_equal nil, photo.box
  end

  def test_with_wrong_token
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', 'tonytonyjanggyy'
    assert photo.persisted?
    assert_equal nil, photo.box
  end

  # def test_duplicated_source
  #   stub_request_for_image
  #   p1 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me'
  #   p2 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me'
  #   p3 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg'
  #   assert_equal p1, p2
  #   refute_equal p1, p3
  # end
end
