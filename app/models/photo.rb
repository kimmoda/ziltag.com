class Photo < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :ziltaggings

  # validations
  validates :user, :image, presence: true

  # callbacks

  # other

end
