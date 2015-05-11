class Photo < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :ziltaggings, foreign_key: :image_url, primary_key: :url
  has_many :posts, through: :ziltaggings

  # validations
  validates :user, :image, presence: true

  # callbacks
  before_save :previous_ziltaggings, if: :image_changed?
  after_save :cache_url, :update_ziltaggings, if: :image_changed?

  # other
  def previous_ziltaggings
    @previous_ziltaggings = ziltaggings
  end

  def cache_url
    update_column :url, image_url
  end

  def update_ziltaggings
    @previous_ziltaggings.update_all image_url: image_url
  end

end
