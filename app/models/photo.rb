class Photo < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  mount_uploader :image, ImageUploader

  # associations
  belongs_to :user

  # validations

  # callbacks

  # other

end
