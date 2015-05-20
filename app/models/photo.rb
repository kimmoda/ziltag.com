class Photo < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user
  has_many :ziltaggings
  has_many :posts, through: :ziltaggings
  has_many :comments

  # validations
  validates :user, :image, presence: true

  # callbacks
  after_save :set_source, if: ->{ source.blank? }

  # other
  def set_source
    update_column :source, image_url
  end

end
