class Collecting < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  belongs_to :collectable, polymorphic: true

  # validations

  # callbacks

  # other

end
