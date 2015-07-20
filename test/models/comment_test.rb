require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'either email or user should exists' do
    shared_params = {x: 100, y: 200, text: 'test', photo: photos(:tony)}
    refute Comment.new(shared_params).valid?
    assert Comment.new(shared_params.merge(email: 'xxx@yyy.zzz')).valid?
    assert Comment.new(shared_params.merge(user: users(:tony))).valid?
  end

  test 'x, y should exists if comment_id is nil' do
    assert Comment.new(comment_id: comments(:tony).id, email: 'xxx@yyy.zzz', text: 'test', photo: photos(:tony)).valid?
    assert Comment.new(x: 123, y: 456, email: 'xxx@yyy.zzz', text: 'test', photo: photos(:tony)).valid?
    refute Comment.new(email: 'xxx@yyy.zzz', text: 'test', photo: photos(:tony)).valid?
  end

  test 'set email from user' do
    comment = Comment.create! x: 123, y: 456, text: 'test', photo: photos(:tony), user: users(:tony)
    assert_equal 'tonytonyjan@ziltag.com', comment.email
  end

  test 'set coordinates from root' do
    comment = Comment.create! text: 'test', photo: photos(:tony), user: users(:tony), root: comments(:tony)
    assert_equal comments(:tony).x, comment.x
    assert_equal comments(:tony).y, comment.y
  end
end
