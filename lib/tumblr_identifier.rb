# frozen_string_literal: true
require 'uri'

module TumblrIdentifier
  REGEXP = /_\d+\.\w+/
  def self.identify url
    uri = URI(url)
    return nil unless uri.host.end_with? 'media.tumblr.com'
    REGEXP.match(uri.path).pre_match
  end
end