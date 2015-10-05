class Photo < ActiveRecord::Base
  include Slugable

  def self.find_or_create_by_source_and_href_and_token! source, href = nil, token = nil
    if box = Box.find_by(token: token)
      find_by(source: source, href: href, box: box) || create!(remote_image_url: source, href: href, box: box)
    else
      find_by(source: source, href: href) || create!(remote_image_url: source, href: href)
    end
  end

  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  belongs_to :box
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
