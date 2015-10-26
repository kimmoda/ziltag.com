require 'test_helper'

class PhotoJobTest < ActiveJob::TestCase
  def test_perform
    stub_request_for_image
    source = 'http://webmock.me/jpeg'
    photo = Photo.create!(source: source)
    PhotoJob.perform_now photo, source
    assert photo.image?
  end

  def test_destroy_photo_if_404
    stub_request_for_404
    source = 'http://webmock.me/notfound'
    photo = Photo.create!(source: source)
    assert photo.persisted?
    PhotoJob.perform_now photo, source
    refute photo.persisted?
  end

  def test_destroy_photo_if_not_image
    stub_request_for_html
    source = 'http://webmock.me'
    photo = Photo.create!(source: source)
    assert photo.persisted?
    PhotoJob.perform_now photo, source
    refute photo.persisted?
  end

end
