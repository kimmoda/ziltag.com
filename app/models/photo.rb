class Photo < ActiveRecord::Base
  include Slugable

  def self.find_or_create_by_source_and_href_and_token! source, href, token
    box = Box.find_by!(token: token)
    host = URI(href).host
    subdomains = host.split('.')
    photos = box.photos.where(source: source)
    if subdomains[1] == 'blogspot'
      photo = photos.find_by('host LIKE ?', "#{subdomains.first}.blogspot%")
    else
      photo = photos.find_by(host: host)
    end
    photo ||= box.photos.create!(source: source, href: href)
    PhotoJob.perform_later photo, source
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

  # callbacks

  # other

  def to_param
    slug
  end

  def to_s
    image
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
