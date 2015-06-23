require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "#photos" do
    assert_equal [photos(:tony)], posts(:tony).photos
  end

  test "tag_list" do
    assert_equal 'Rails,Ruby', posts(:tony).tag_list
    posts(:tony).tag_list = 'Rails'
    assert_equal 'Rails', posts(:tony).tag_list
    posts(:tony).tag_list = 'Ruby'
    assert_equal 'Ruby', posts(:tony).tag_list
    posts(:tony).tag_list = 'AAA,BBB,CCC'
    assert_equal 'AAA,BBB,CCC', posts(:tony).tag_list
  end
end
