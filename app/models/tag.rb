class Tag < ActiveRecord::Base
  # scopes
  # TODO: use counter cache
  scope :top_5, ->{ Tag.joins(:posts).select('tags.*, count(posts.id) AS posts_count').group(:id).order("posts_count DESC").limit(5) }

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
