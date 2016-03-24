require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @token = boxes(:tony).token
    @blogger_token = boxes(:blogger).token
    @localhost_token = boxes(:localhost).token
  end

  def test_find_by_token_src_and_href
    stub_request_for_image
    p1 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://webmock.me', token: 'tonytonyjan'
    p2 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://localhost:3000', token: 'tonytonyjan_localhost'
    refute p1
    assert p2
  end

  def test_find_tumblr
    p1 = Photo.find_by_token_src_and_href source: 'http://38.media.tumblr.com/31bc9b6e03697efd9c171a1607b5b26f/tumblr_inline_nqpg3pMhqd1rrdigq_400.gif', href: 'http://localhost:3000', token: 'tonytonyjan_localhost'
    p2 = Photo.find_by_token_src_and_href source: 'http://44.media.tumblr.com/31bc9b6e03697efd9c171a1607b5b26f/tumblr_inline_nqpg3pMhqd1rrdigq_300.jpg', href: 'http://localhost:3000', token: 'tonytonyjan_localhost'
    p3 = Photo.find_by_token_src_and_href source: 'http://12.media.tumblr.com/31bc9b6e03697efd9c171a1607b5b26f/tumblr_inline_nqpg3pMhqd1rrdigq_100.gif', href: 'http://localhost:3000', token: 'tonytonyjan_localhost'
    assert_equal p1, photos(:tumblr)
    assert_equal p2, photos(:tumblr)
    assert_equal p3, photos(:tumblr)
  end

  def test_same_domain
    stub_request_for_image
    p1 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://localhost/aaa', token: 'tonytonyjan_localhost'
    p2 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://localhost/bbb', token: 'tonytonyjan_localhost'
    assert_equal photos(:one), p1
    assert_equal photos(:one), p2
  end

  # def test_permission
  #   assert_raises do
  #     Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.tw/bbb', @token, width: 200, height: 200
  #   end
  # end

  def test_blogspot
    stub_request_for_image
    p1 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://tony.blogspot.tw/aaa', token: 'tonytonyjan_blogger'
    p2 = Photo.find_by_token_src_and_href source: 'http://webmock.me/jpeg', href: 'http://tony.blogspot.jp/bbb', token: 'tonytonyjan_blogger'
    assert_equal photos(:blogger), p1
    assert_equal photos(:blogger), p2
  end

  def test_find_existed_image
    stub_request_for_image
    p1 = photos(:one)
    p2 = Photo.find_by_token_src_and_href source: p1.source, href: p1.href, token: 'tonytonyjan_localhost'
    assert_equal p1, p2
  end

  # def test_duplicated_source
  #   stub_request_for_image
  #   p1 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', @token, width: 200, height: 200
  #   p2 = Photo.find_or_create_by_source_and_href_and_token! 'http://webmock.me/jpeg', 'http://webmock.me', @token, width: 200, height: 200
  #   assert_equal p1, p2
  # end
end
