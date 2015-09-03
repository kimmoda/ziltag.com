class Sticker < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :photo
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validations

  # callbacks

  # other

end
