class Photo < ActiveRecord::Base
  include Slugable
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :ziltags, dependent: :destroy

  # validations
  validates :image, presence: true

  # callbacks
  after_save :set_source, if: ->{ source.blank? }

  # other
  def set_source
    uri = URI(remote_image_url.presence || image_url)
    uri.normalize!
    update_column :source, uri.to_s
  end

  def to_param
    slug
  end

  def to_s
    image
  end

end
