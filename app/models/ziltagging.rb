class Ziltagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  delegate :title, :content, :user, to: :post

  # associations
  belongs_to :post

  def photo
    # TODO 若會影響效能再考慮在 photos 建立快取欄位，並索引
    candidates = Photo.where(image: File.basename(image_url))
    candidates.find{ |i| i.image_url == image_url }
  end

  # validations

  # callbacks

  # other

end
