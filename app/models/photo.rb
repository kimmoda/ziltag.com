class Photo < ActiveRecord::Base
  include Slugable

  def self.find_or_create_by_source_and_href_and_token! source, href, token, **create_options
    box = Box.find_by!(token: token)
    raise "#{href} is not permitted by given token" unless box.match_href?(href)
    photo = box.photos.find_or_create_by_source_and_uri! source, href, **create_options
    PhotoJob.perform_later photo, source unless photo.image?
    photo
  end

  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader
  delegate :token, to: :box

  # associations
  belongs_to :user
  belongs_to :box
  has_many :ziltags, dependent: :destroy

  # validations
  validates :href, format: /\A#{URI::regexp}\z/, allow_nil: true
  validates :width, :height, presence: true

  # callbacks

  # other

  def to_param
    slug
  end

  def to_s
    read_attribute(:image)
  end

  def href= value
    super
    if href =~ /\A#{URI::regexp}\z/
      uri = URI(href)
      self.host, self.path = uri.host, uri.path
    else
      logger.warn "invalid URI format: #{value}"
    end
  end

end
