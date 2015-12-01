require 'test_helper'

class PhotoJobTest < ActiveJob::TestCase
  def test_perform
    stub_request_for_image
    source = 'http://webmock.me/jpeg'
    photo = Photo.create!(source: source, width: 200, height: 200)
    PhotoJob.perform_now photo, source
    assert photo.image?
  end

  def test_update_dimensions
    stub_request_for_image
    source = 'http://webmock.me/jpeg'
    photo = Photo.create!(source: source, width: 210, height: 200)
    assert_equal 210, photo.width
    PhotoJob.perform_now photo, source
    assert_equal 200, photo.width
  end

  def test_destroy_photo_if_404
    stub_request_for_404
    source = 'http://webmock.me/notfound'
    photo = Photo.create!(source: source, width: 200, height: 200)
    assert photo.persisted?
    PhotoJob.perform_now photo, source
    refute photo.persisted?
  end

  def test_destroy_photo_if_not_image
    stub_request_for_html
    source = 'http://webmock.me'
    photo = Photo.create!(source: source, width: 200, height: 200)
    assert photo.persisted?
    PhotoJob.perform_now photo, source
    refute photo.persisted?
  end

end
