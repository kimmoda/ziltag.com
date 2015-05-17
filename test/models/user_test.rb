require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#follow?' do
    tony = users(:tony)
    david = users(:david)
    assert tony.follow?(david)
    refute david.follow?(tony)
  end
end
