require 'test_helper'

class ZiltaggingTest < ActiveSupport::TestCase
  test "#photo" do
    assert_equal photos(:tony), ziltaggings(:tony).photo
  end
end
