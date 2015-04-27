class Photo < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user

  def ziltaggings
    Ziltagging.where(image_url: image_url)
  end

  def posts
    Post.joins(:ziltaggings).where(ziltaggings: {image_url: image_url})
  end

  # validations
  validates :user, :image, presence: true

  # callbacks

  # other

end
