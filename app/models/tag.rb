class Tag < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  has_many :taggings
  has_many :posts, through: :taggings, source: :taggable, source_type: 'Post'
  has_many :ziltaggings, through: :posts

  # validations

  # callbacks

  # other

end
