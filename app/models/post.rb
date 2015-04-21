class Post < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :ziltaggings

  def photos
    ziltaggings.map(&:photo)
  end

  # validations
  validates :user, :title, :content, presence: true

  # callbacks

  # other

end
