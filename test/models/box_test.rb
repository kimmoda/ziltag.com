require 'test_helper'

class BoxTest < ActiveSupport::TestCase
  def test_service
    assert_equal 'tumblr', Box.new(host: 'weihang.tumblr.com').service
    assert_equal 'wordpress', Box.new(host: 'weihang.wordpress.com').service
    assert_equal 'pixnet', Box.new(host: 'weihang.pixnet.net').service
    assert_equal 'logdown', Box.new(host: 'weihang.logdown.com').service
    assert_equal 'blogger', Box.new(host: 'weihang.blogspot.tw').service
    assert_equal 'blogger', Box.new(host: 'weihang.blogspot.jp').service
    assert_equal nil, Box.new(host: 'tonytonyjan.net').service
    assert_equal nil, Box.new(host: '').service
  end
end
