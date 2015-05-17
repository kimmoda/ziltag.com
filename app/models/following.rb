class Following < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :follower, class_name: User
  belongs_to :leader, class_name: User

  # validations

  # callbacks

  # other

end
