require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  test '::find_or_create_by_url!' do
    photo_params = {remote_image_url: 'http://tonytonyjan.net/images/site/avatar.png'}
    photo_1 = Photo.find_or_create_by_url! photo_params
    photo_2 = Photo.find_or_create_by_url! photo_params
    assert_equal photo_1, photo_2
  end

  test '::search_by_urls' do
    ids = Photo.search_by_urls(%w[http://localhost:3000/uploads/photos/image/2/tony.jpg http://localhost:3000/uploads/photos/image/3/tony.jpg]).pluck(:id)
    assert_equal photos(:tony_2, :david).map!(&:id).sort!, ids.sort!
  end

  test '#ziltaggings' do
    assert_equal photos(:tony).ziltaggings, [ziltaggings(:tony)]
  end

  test '#posts' do
    assert_equal photos(:tony).posts, [posts(:tony)]
  end

end
