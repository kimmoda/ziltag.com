class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  def tag_list
    tags.map(&:name).join(',')
  end

  def tag_list= list
    self.tags = list.split(',').map do |tag_name|
      Tag.find_or_create_by name: tag_name
    end
  end

  # associations
  belongs_to :user
  has_many :ziltaggings, inverse_of: :post, dependent: :destroy
  has_many :photos, through: :ziltaggings
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :ziltaggings, allow_destroy: true

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other

  def to_s
    title
  end

end
