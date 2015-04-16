class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :ziltaggings
  has_many :photos, through: :ziltaggings

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other

end
