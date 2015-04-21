require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test '#ziltaggings' do
    assert_equal photos(:tony).ziltaggings, [ziltaggings(:tony)]
  end

  test '#posts' do
    assert_equal photos(:tony).posts, [posts(:tony)]
  end
end
