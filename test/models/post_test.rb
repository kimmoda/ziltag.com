require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "#photos" do
    assert_equal [photos(:tony)], posts(:tony).photos
  end
end
