class Ziltagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :post

  def photo
    Photo.find_by(image: File.basename(image_url))
  end

  # validations

  # callbacks

  # other

end
