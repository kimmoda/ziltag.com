class Ziltag < ActiveRecord::Base
  # scopes
  scope :by_image_source, ->(urls){ joins(:photo).where(photos: {source: urls}) }

  # constants

  # attributes
  delegate :source, to: :photo
  delegate :username, to: :user

  # associations
  belongs_to :photo
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validations

  # callbacks

  # other

end
