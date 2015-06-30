require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test 'shoud show post' do
    post = posts(:tony)
    sign_in users(:tony)
    get :show, format: :json, id: post.id
    assert_response :success
  end

  test 'should get one\'s posts' do
    sign_in users(:tony)
    get :index, format: :json
    assert_response :success
  end

  test 'should create post and ziltagging' do
    sign_in users(:tony)
    post :create,
      format: :json,
      post: {
        title: '謝謝你',
        content: '<p>九五二七</p>'
      },
      ziltagging: {x: 123, y: 321, photo_id: photos(:tony).id}
    assert_response :success
  end

  test 'should create single post' do
    sign_in users(:tony)
    post :create,
      format: :json,
      post: {
        title: '謝謝你',
        content: '<p>九五二七</p>'
      }
    assert_response :success
  end

  test 'should update post' do
    post = posts(:tony)
    sign_in users(:tony)
    put :update,
      id: post.id,
      format: :json,
      post: {
        title: '哈囉',
        content: '<p>世界</p>'
      }
    assert_response :success
    post.reload
    assert_equal '哈囉', post.title
    assert_equal '<p>世界</p>', post.content
  end

  test 'should delete post' do
    post = posts(:tony)
    sign_in users(:tony)
    delete :destroy, id: post.id, format: :json
    assert_response :success
    refute Post.exists? id: post.id
  end

end
