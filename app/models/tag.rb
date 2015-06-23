class Tag < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  has_many :taggings
  has_many :posts, through: :taggings, source: :taggable, source_type: 'Post'

  # validations

  # callbacks

  # other

end
