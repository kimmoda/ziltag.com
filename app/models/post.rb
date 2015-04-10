class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :ziltaggings

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other

end
