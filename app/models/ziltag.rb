class Ziltag < ActiveRecord::Base
  include Slugable
  include Confirmable
  # scopes

  # constants

  # attributes
  delegate :source, to: :photo
  delegate :username, :confirmed?, to: :user
  mount_uploader :share_image, ShareImageUploader

  # associations
  belongs_to :photo
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validations

  # callbacks
  before_save :assign_share_image, if: ->{x_changed? || y_changed?}

  # other
  def to_param
    slug
  end

  def assign_share_image
    self.remote_share_image_url = photo.image_url
  end

  def generate_share_image!
    update remote_share_image_url: photo.image_url
  end

end
