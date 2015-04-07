class Admin::Comment < Comment
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
