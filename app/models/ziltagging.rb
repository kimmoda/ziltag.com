class Ziltagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  delegate :title, :content, :user, to: :post
  delegate :image_url, to: :photo

  # associations
  has_many :tags, through: :post
  belongs_to :post
  belongs_to :photo

  # validations
  validates :post, :photo, presence: true

  # callbacks

  # other
  def other_ziltaggings
    photo.ziltaggings.where.not(id: id)
  end

end
