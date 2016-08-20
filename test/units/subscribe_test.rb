# frozen_string_literal: true
require 'test_helper'
require 'minitest/mock'

class SubscribeTest < Minitest::Test
  def test_subscribe
    user = User.new id: 2
    ziltag = Ziltag.new unsubscribers: [1, 2, 3]
    Subscribe.new(user, ziltag).subscribe
    assert_equal [1, 3], ziltag.unsubscribers
    user.id = 3
    Subscribe.new(user, ziltag).subscribe
    assert_equal [1], ziltag.unsubscribers
  end
end
