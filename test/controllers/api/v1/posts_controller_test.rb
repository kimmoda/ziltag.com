require 'test_helper'

class Api::V1::PostsControllerTest < ActionController::TestCase
  test '#index' do
    get :index, format: :json
    assert_response :success
    json = JSON.parse response.body
    assert json.is_a? Array
  end

  test '#show' do
    get :show, id: posts(:tony).id, format: :json
    json = JSON.parse response.body
    expected = {"id"=>339078012, "user_id"=>339078012, "title"=>"大兜的測試文章", "content"=>"<p>段落一</p><p>段落二</p><p>段落三</p>", "published"=>false}
    assert_equal expected, json.except('updated_at', 'created_at')
  end
end
