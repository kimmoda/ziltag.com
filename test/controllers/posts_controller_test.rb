require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  test 'shoud show post' do
    post = posts(:tony)
    sign_in users(:tony)
    get :show, format: :json, id: post.id
    assert_response :success
    json = JSON.parse response.body
    expected = {
      "id"=>339078012,
      "title"=>"大兜的測試文章",
      "content"=>"<p>段落一</p><p>段落二</p><p>段落三</p>",
      "created_on"=>"2015年6月14日",
      "summary"=>"段落一段落二段落三",
      "first_photo"=>{
        "id"=>339078012,
        "image_url"=>"http://localhost:3000/uploads/photos/image/339078012/tony.jpg",
        "thumb"=>"http://localhost:3000/uploads/photos/image/339078012/thumb_tony.jpg"
      }
    }
    assert_equal expected, json
  end

  test 'should get one\'s posts' do
    sign_in users(:tony)
    get :index, format: :json
    assert_response :success
    json = JSON.parse response.body
    expected = {
      "id"=>339078012,
      "title"=>"大兜的測試文章",
      "content"=>"<p>段落一</p><p>段落二</p><p>段落三</p>",
      "summary"=>"段落一段落二段落三",
      "created_on"=>"2015年6月14日",
      "first_photo"=>{
        "id"=>339078012,
        "image_url"=>"http://localhost:3000/uploads/photos/image/339078012/tony.jpg",
        "thumb"=>"http://localhost:3000/uploads/photos/image/339078012/thumb_tony.jpg"
      }
    }
    assert_equal expected, json.first
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
    json = JSON.parse(response.body)
    json.delete 'id'
    json['ziltagging'].delete 'id'
    expected = {"title"=>"謝謝你",
      "content"=>"<p>九五二七</p>",
      "created_on"=>"2015年6月14日",
      "summary"=>"九五二七",
      "first_photo"=>{
        "id"=>339078012,
        "image_url"=>"http://localhost:3000/uploads/photos/image/339078012/tony.jpg",
        "thumb"=>"http://localhost:3000/uploads/photos/image/339078012/thumb_tony.jpg"
      },
      "ziltagging"=>{
        "x"=>123, "y"=>321,
        "photo_id"=>339078012
      }
    }
    assert_equal expected, json
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
    json = JSON.parse(response.body)
    json.delete 'id'
    expected = {
      "title"=>"謝謝你",
      "content"=>"<p>九五二七</p>",
      "created_on"=>"2015年6月14日",
      "summary"=>"九五二七"
    }
    assert_equal expected, json
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
    json = JSON.parse response.body
    expected = {"id"=>339078012, "title"=>"哈囉", "content"=>"<p>世界</p>", "created_on"=>"2015年6月14日", "summary"=>"世界", "first_photo"=>{"id"=>339078012, "image_url"=>"http://localhost:3000/uploads/photos/image/339078012/tony.jpg", "thumb"=>"http://localhost:3000/uploads/photos/image/339078012/thumb_tony.jpg"}}
    assert_equal expected, json
  end

  test 'should delete post' do
    post = posts(:tony)
    sign_in users(:tony)
    delete :destroy, id: post.id, format: :json
    assert_response :success
    refute Post.exists? id: post.id
    json = JSON.parse response.body
    expected = {"id"=>339078012, "ziltagging_ids"=>[339078012]}
    assert_equal expected, json
  end

end
