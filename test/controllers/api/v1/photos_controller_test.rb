# frozen_string_literal: true
require 'test_helper'

class Api::V1::PhotosControllerTest < ActionController::TestCase
  def test_show
    get :show, format: :json, id: photos(:one).natural_id
    assert_response :ok
    json = JSON.parse response.body
    assert_equal 'oneone', json['id']
  end
end
