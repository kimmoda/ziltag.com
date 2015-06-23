class Tagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :tag
  belongs_to :taggable, polymorphic: true

  # validations

  # callbacks

  # other

end
