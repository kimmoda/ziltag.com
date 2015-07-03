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

  test '#find_or_create_by_url!' do
    photo_params = {remote_image_url: 'http://tonytonyjan.net/images/site/avatar.png'}
    photo_1 = @tony.photos.find_or_create_by_url! photo_params
    photo_2 = @tony.photos.find_or_create_by_url! photo_params
    assert_equal photo_1, photo_2
  end

end
