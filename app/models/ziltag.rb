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
  after_create :notify_create
  after_update :notify_update, if: ->{ x_changed? || y_changed? || content_changed? }

  # other
  def to_param
    slug
  end

  def generate_share_image_later
    ZiltagImageJob.perform_later self
  end

private

  def notify_stream action
    Ziltag.connection.execute "NOTIFY #{action}_ziltag, '#{id}'"
  end

  def notify_create
    notify_stream 'create'
  end

  def notify_update
    notify_stream 'update'
  end

end
