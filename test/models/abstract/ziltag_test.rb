require 'test_helper'

class Abstract::ZiltagTest < ActiveSupport::TestCase
  def setup
    @file = File.new(Rails.root.join('test', 'fixtures', 'images', '1.jpg'))
  end

  test '#save!' do
    tony = users(:tony)
    ziltag = Abstract::Ziltag.new({
      photo: tony.photos.new({
        image: @file
      }),
      post: tony.posts.new({
        title: 'Hello',
        content: 'World',
        published: true
      }),
      ziltagging: Ziltagging.new({x: 12, y: 32})
    })
    ziltag.save!
    assert ziltag.photo.persisted?
    assert ziltag.post.persisted?
    assert ziltag.ziltagging.persisted?
    assert_equal ziltag.ziltagging.post_id, ziltag.post.id
    assert_equal ziltag.ziltagging.photo_id, ziltag.photo.id
  end

  test '#save! faield' do
    tony = users(:tony)
    ziltag = Abstract::Ziltag.new({
      photo: tony.photos.new({
        image: @file
      }),
      post: tony.posts.new({
        title: 'Hello',
        content: 'World',
        published: true
      }),
      ziltagging: Ziltagging.new({y: 32})
    })
    assert_raises ActiveRecord::RecordInvalid do
      ziltag.save!
    end
    refute ziltag.photo.persisted?
    refute ziltag.post.persisted?
    refute ziltag.ziltagging.persisted?
  end

end
