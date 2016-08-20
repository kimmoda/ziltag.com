# frozen_string_literal: true
require 'test_helper'

class WebsiteTest < ActiveSupport::TestCase
  def test_service
    assert_equal 'tumblr', Website.new(url: 'http://weihang.tumblr.com').service
    assert_equal 'wordpress', Website.new(url: 'http://weihang.wordpress.com').service
    assert_equal 'pixnet', Website.new(url: 'http://weihang.pixnet.net').service
    assert_equal 'xuite', Website.new(url: 'http://blog.xuite.net/foo/bar').service
    assert_equal 'logdown', Website.new(url: 'http://weihang.logdown.com').service
    assert_equal 'blogger', Website.new(url: 'http://weihang.blogspot.tw').service
    assert_equal 'blogger', Website.new(url: 'http://weihang.blogspot.jp').service
    assert_equal nil, Website.new(url: 'http://tonytonyjan.net').service
    assert_equal nil, Website.new(url: '').service
  end

  def test_match_href
    website = Website.new(url: 'http://weihang.blogspot.tw')
    assert website.match_href? 'http://weihang.blogspot.tw/foo/bar'
    assert website.match_href? 'http://weihang.blogspot.jp/foo/bar'
    refute website.match_href? 'http://jian.blogspot.jp/foo/bar'
    website = Website.new(url: 'http://weihang.tumblr.com')
    assert website.match_href? 'http://weihang.tumblr.com/foo/bar'
  end

  def test_match_href_without_protocol
    website = Website.new(url: 'weihang.blogspot.tw')
    assert website.match_href? 'http://weihang.blogspot.tw/foo/bar'
    assert website.match_href? 'http://weihang.blogspot.jp/foo/bar'
    refute website.match_href? 'http://jian.blogspot.jp/foo/bar'
    website = Website.new(url: 'weihang.tumblr.com')
    assert website.match_href? 'http://weihang.tumblr.com/foo/bar'
  end
end
