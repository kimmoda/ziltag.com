require 'test_helper'
require 'service_url_converter'

class ServiceURLConverterTest < Minitest::Test
  def test_convert
    assert_equal 'http://tonytonyjan.net', ServiceURLConverter.convert({platform: 'general', url: 'http://tonytonyjan.net'})
    assert_equal 'http://tonytonyjan.tumblr.com', ServiceURLConverter.convert({platform: 'tumblr', blog_id: 'tonytonyjan'})
    assert_equal 'http://tonytonyjan.wordpress.com', ServiceURLConverter.convert({platform: 'wordpress', blog_id: 'tonytonyjan'})
    assert_equal 'http://tonytonyjan.blogspot.com', ServiceURLConverter.convert({platform: 'blogger', blog_id: 'tonytonyjan'})
  end
end