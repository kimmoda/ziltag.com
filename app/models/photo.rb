class Photo < ActiveRecord::Base
  # scopes
  scope :search_by_urls, ->(urls){ includes(:ziltaggings).where(source: urls) }
  scope :has_ziltaggings, ->{ joins(:ziltaggings).group('photos.id', 'ziltaggings.photo_id').having('count(ziltaggings.id) > 0') }

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :ziltaggings
  has_many :posts, through: :ziltaggings
  has_many :comments

  # validations
  # TODO 應該有更好的做法
  # validates :image, presence: true

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
