class Photo < ActiveRecord::Base
  include Slugable

  def self.find_or_create_by_source_and_href_and_token! source, href = nil, token = nil
    box = Box.find_by(token: token)
    photo = find_by(source: source, href: href, box: box) || create!(source: source, href: href, box: box)
    PhotoJob.perform_later photo, source
    photo
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

  # callbacks

  # other

  def to_param
    slug
  end

  def to_s
    image
  end

end
