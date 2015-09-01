class Photo < ActiveRecord::Base
  # scopes
  scope :search_by_urls, ->(urls){ includes(:ziltaggings).where(source: urls) }
  scope :has_ziltaggings, ->{ joins(:ziltaggings).group('photos.id', 'ziltaggings.photo_id').having('count(ziltaggings.id) > 0') }

  def self.find_or_create_by_url! params
    if remote_image_url = params[:remote_image_url].presence
      uri = URI(remote_image_url)
      uri.normalize!
      photo = find_by source: uri.to_s
    end
    photo ||= create! params
  end

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :stickers, dependent: :destroy
  has_many :ziltaggings, dependent: :destroy
  has_many :posts, through: :ziltaggings
  has_many :comments, dependent: :destroy

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

  def to_s
    image
  end

end
