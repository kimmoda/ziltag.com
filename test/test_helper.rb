require 'codeclimate-test-reporter'
require 'webmock/minitest'
require 'stub_requests'

CodeClimate::TestReporter.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include StubRequests
end

ActionController::TestCase.include(Devise::TestHelpers)