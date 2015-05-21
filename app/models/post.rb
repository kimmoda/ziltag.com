class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :ziltaggings, inverse_of: :post
  accepts_nested_attributes_for :ziltaggings

  def photos
    ziltaggings.map(&:photo)
  end

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other

end
