require 'test_helper'
require 'tumblr_identifier'

class TumblrIdentifierTest < MiniTest::Unit::TestCase
  def test_identify
    assert_equal nil, TumblrIdentifier.identify('http://tonytonyjan.net')
    assert_equal '/31bc9b6e03697efd9c171a1607b5b26f/tumblr_inline_nqpg3pMhqd1rrdigq', TumblrIdentifier.identify('http://38.media.tumblr.com/31bc9b6e03697efd9c171a1607b5b26f/tumblr_inline_nqpg3pMhqd1rrdigq_540.gif')
    assert_equal '/cec392d6b48860e9d12a5e8a73e5d6eb/tumblr_n7rnlnHeYz1sg40ozo1', TumblrIdentifier.identify('http://41.media.tumblr.com/cec392d6b48860e9d12a5e8a73e5d6eb/tumblr_n7rnlnHeYz1sg40ozo1_400.jpg')
    assert_equal '/ea8fdb41cf982dae1b9fbbc14cddc970/tumblr_o3bgkvpubb1ukgq23o1', TumblrIdentifier.identify('http://41.media.tumblr.com/ea8fdb41cf982dae1b9fbbc14cddc970/tumblr_o3bgkvpubb1ukgq23o1_1280.png')
    assert_equal '/tumblr_lmkcdkHeGo1qb9qwwo1', TumblrIdentifier.identify('http://40.media.tumblr.com/tumblr_lmkcdkHeGo1qb9qwwo1_500.jpg')
  end
end