class Comment < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  # validations

  # callbacks

  # other

end
