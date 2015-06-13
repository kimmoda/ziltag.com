class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :ziltaggings, inverse_of: :post, dependent: :destroy
  has_many :photos, through: :ziltaggings
  accepts_nested_attributes_for :ziltaggings, allow_destroy: true

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other
  def to_s
    title
  end

end
