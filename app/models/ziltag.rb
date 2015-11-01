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
  after_save :generate_share_image_later, if: ->{ photo.image? && (!share_image? || x_changed? || y_changed?) }
  after_save :notify_stream

  # other
  def to_param
    slug
  end

  def generate_share_image_later
    ZiltagImageJob.perform_later self
  end

private

  def notify_stream
    photo.ziltags.where.not(id: self).each do |ziltag|
      Ziltag.connection.execute "NOTIFY slug_#{ziltag.slug}, 'ziltag_#{id}'" if x_changed? || y_changed? || content_changed?
    end
  end

end
