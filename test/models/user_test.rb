require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @tony = users(:tony)
    @david = users(:david)
  end

  test '#follow?' do
    assert @tony.follow?(@david)
    refute @david.follow?(@tony)
  end

  test '#follow!' do
    refute @david.follow?(@tony)
    @david.follow!(@tony)
    assert @david.follow?(@tony)
  end

  test '#unfollow!' do
    assert @tony.follow?(@david)
    @tony.unfollow!(@david)
    refute @tony.follow?(@david)
  end

  test 'follow twice' do
    refute @david.follow?(@tony)
    @david.follow!(@tony)
    @david.follow!(@tony)
    assert @david.follow?(@tony)
  end

  test 'unfollow twice' do
    assert @tony.follow?(@david)
    @tony.unfollow!(@david)
    @tony.unfollow!(@david)
    refute @tony.follow?(@david)
  end
end
