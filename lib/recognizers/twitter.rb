# frozen_string_literal: true
require 'uri'
module Recognizers
  class Twitter
    attr_reader :status_uri
    def initialize(content)
      @content = content
      @status_uri = URI.extract(@content).find do |uri|
        uri =~ %r{twitter\.com/.*/status/\d+}
      end
    end

    def matched?
      !!@status_uri
    end
  end
end
