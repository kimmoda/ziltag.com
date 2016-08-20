# frozen_string_literal: true
class Ziltag < ActiveRecord::Base
  include Natural
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
  validates :content, length: { maximum: 5000 }

  # callbacks
  after_save :generate_share_image_later, if: -> { photo.image? && (!share_image? || x_changed? || y_changed?) }

  # other
  def to_param
    natural_id
  end

  def generate_share_image_later
    ZiltagImageJob.perform_later self
  end

  def to_s
    content.truncate(20)
  end

  def map_id
    photo.natural_id
  end

  def map_id=(value)
    self.photo = Photo.find_by(natural_id: value)
  end
end
