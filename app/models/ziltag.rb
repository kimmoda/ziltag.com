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
  after_update :notify_update, if: ->{ content_changed? }
  after_destroy :notify_destroy

  # other
  def to_param
    slug
  end

  def generate_share_image_later
    ZiltagImageJob.perform_later self
  end

  def to_s
    content.truncate(20)
  end

  def map_id
    photo.slug
  end

  def map_id= value
    self.photo = Photo.find_by(slug: value)
  end

private

  def notify_stream action, payload
    Ziltag.connection.execute "NOTIFY #{action}_ziltag, '#{payload.to_json.gsub("'", "''")}'"
  end

  def notify_create
    notify_stream :create, sse_json
  end

  def notify_update
    notify_stream :update, sse_json
  end

  def sse_json
    {
      slug: photo.ziltags.pluck(:slug),
      content: content,
      id: slug,
      map_id: photo.slug,
      usr: {
        avatar: user.avatar.thumb.url,
        name: user.username
      }
    }
  end

  def notify_destroy
    notify_stream 'delete', {slug: photo.ziltags.pluck(:slug), id: slug}
  end

end
