require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  def test_service
    assert_equal 'tumblr', Box.new(url: 'http://weihang.tumblr.com').service
    assert_equal 'wordpress', Box.new(url: 'http://weihang.wordpress.com').service
    assert_equal 'pixnet', Box.new(url: 'http://weihang.pixnet.net').service
    assert_equal 'xuite', Box.new(url: 'http://blog.xuite.net/foo/bar').service
    assert_equal 'logdown', Box.new(url: 'http://weihang.logdown.com').service
    assert_equal 'blogger', Box.new(url: 'http://weihang.blogspot.tw').service
    assert_equal 'blogger', Box.new(url: 'http://weihang.blogspot.jp').service
    assert_equal nil, Box.new(url: 'http://tonytonyjan.net').service
    assert_equal nil, Box.new(url: '').service
  end
end
