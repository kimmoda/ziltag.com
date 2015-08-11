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

  test '#collect?' do
    assert @tony.collect? posts(:david)
    refute @david.collect? posts(:tony)
  end

  test '#collect!' do
    refute @david.collect?(posts(:tony))
    @david.collect!(posts(:tony))
    assert @david.collect?(posts(:tony))
  end

  test '#uncollect' do
    assert @tony.collect?(posts(:david))
    @tony.uncollect!(posts(:david))
    refute @tony.collect?(posts(:david))
  end

  test 'collect twice' do
    refute @david.collect?(posts(:tony))
    @david.collect!(posts(:tony))
    @david.collect!(posts(:tony))
    assert @david.collect?(posts(:tony))
  end

  test 'uncollect twice' do
    assert @tony.collect?(posts(:david))
    @tony.uncollect!(posts(:david))
    @tony.uncollect!(posts(:david))
    refute @tony.collect?(posts(:david))
  end

  test 'username validation' do
    opt = {email: 'tony@gmail.com', password: 'password'}
    assert User.new(opt.merge(username: 'tonyjan')).valid?
    assert User.new(opt.merge(username: 'tony_jan')).valid?
    refute User.new(opt.merge(username: 'tony-jan')).valid?
    refute User.new(opt.merge(username: 'tony.jan')).valid?
  end

end
