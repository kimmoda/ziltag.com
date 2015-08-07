require 'test_helper'

class Api::V1::ZiltaggingsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json
    assert_response :success
    json = JSON.parse response.body
    assert json.is_a? Array
  end

  test '#show' do
    get :show, id: ziltaggings(:tony).id, format: :json
    json = JSON.parse response.body
    expected = {"id"=>339078012, "post_id"=>339078012, "photo_id"=>339078012, "x"=>20, "y"=>20}
    assert_equal expected, json.except('updated_at', 'created_at')
  end
end
