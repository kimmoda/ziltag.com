require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, photo_id: comments(:tony).id, format: :json
    assert_response :success
  end

  test "should get show" do
    get :show, id: comments(:tony), format: :json
    assert_response :success
  end

  test 'should create comment' do
    post :create, format: :json, comment: {
      text: '留言測試',
      x: 123,
      y: 456,
      email: 'xxx@yyy.zzz',
      photo_id: photos(:tony).id
    }
    assert_response :success
  end

  test 'should update comment' do
    put :update, id: comments(:tony).id, format: :json, comment: {
      text: '留言測試',
      x: 123,
      y: 456,
      email: 'xxx@yyy.zzz',
      photo_id: photos(:tony).id
    }
    assert_response :success
    data = JSON.parse response.body
    assert_equal '留言測試', data['text']
    assert_equal 123, data['x']
    assert_equal 456, data['y']
  end

  test 'should destroy comment' do
    comment_id = comments(:tony).id
    assert Comment.exists? comment_id
    delete :destroy, id: comment_id
    refute Comment.exists? comment_id
    assert_response :success
  end

end
