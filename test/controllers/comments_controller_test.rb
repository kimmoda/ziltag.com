require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    get :index, photo_id: comments(:tony).id, format: :json
    assert_response :success
    json = JSON.parse response.body
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

  test 'should create comment form signed in user' do
    sign_in users(:tony)
    post :create, format: :json, comment: {
      comment_id: '',
      email: '',
      photo_id: photos(:tony).id,
      text: 'sss',
      x: 123,
      y: 456,
    }
    assert_response :success
    json = JSON.parse response.body
    assert_equal json['user']['username'], 'tonytonyjan'
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
    nested_id = comments(:nested).id

    assert Comment.exists? comment_id
    delete :destroy, id: comment_id
    refute Comment.exists? comment_id
    refute Comment.exists? nested_id
    assert_response :success
  end

end
