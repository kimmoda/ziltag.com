require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_shoud_have_one_box_after_creation
    cp = ContentProvider.create! email: 'test@ziltag.com', password: 'password'
    user = User.create! email: 'test2@ziltag.com', username: 'testtest2', password: 'password'
    assert cp.boxes.present?
    assert user.boxes.empty?
  end

  def test_will_generate_box_automatically
    user = users(:tony)
    user.boxes.destroy_all
    assert user.boxes.empty?
    assert user.box.persisted?
    assert user.boxes.present?
  end
end
