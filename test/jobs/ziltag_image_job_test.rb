require 'test_helper'

class ZiltagImageJobTest < ActiveJob::TestCase
  def test_perform
    ziltag = ziltags(:tony)
    stub_request(:get, ziltag.photo.image_url)
      .to_return(
        body: File.new(Rails.root.join('test', 'fixtures', 'images', '1.jpg')),
        status: 200,
        headers: {'Content-Type' => 'image/jpeg'}
      )
    refute ziltag.share_image?
    ZiltagImageJob.perform_now ziltag
    assert ziltag.share_image?
  end

  def test_enqueue_ziltag_image_jobs_after_photo_job
    stub_request_for_image
    source = 'http://webmock.me/jpeg'
    photo = Photo.create!(source: source, width: 200, height: 200)
    ziltag = photo.ziltags.create! user: users(:tony), content: 'hello', x: 0.5, y: 0.5
    ziltag = photo.ziltags.create! user: users(:tony), content: 'world', x: 0.5, y: 0.5
    PhotoJob.perform_now photo, source
    assert_enqueued_jobs 2
  end

  def test_enqueue_after_zilag_saged
    photos(:one).image?
    stub_request_for_image
    source = 'http://webmock.me/jpeg'
    photo = Photo.create!(source: source, width: 200, height: 200)
    PhotoJob.perform_now photo, source
    assert_enqueued_jobs 0
    photo.ziltags.create! user: users(:tony), x: 0.5, y: 0.5, content: 'hello'
    assert_enqueued_jobs 1
    photo.ziltags.create! user: users(:tony), x: 0.5, y: 0.5, content: 'hello'
    assert_enqueued_jobs 2
  end
end
