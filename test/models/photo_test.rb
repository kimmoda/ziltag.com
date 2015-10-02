require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def test_find_or_create_by_source_and_href!
    stub_request_for_image
    photo = Photo.find_or_create_by_source_and_href! 'http://webmock.me/jpeg', 'http://webmock.me'
    assert photo.persisted?
  end

  def test_duplicate_source
    stub_request_for_image
    p1 = Photo.find_or_create_by_source_and_href! 'http://webmock.me/jpeg', 'http://webmock.me'
    p2 = Photo.find_or_create_by_source_and_href! 'http://webmock.me/jpeg'
    refute_equal p1, p2
  end
end
