class Ziltagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  delegate :title, :content, :user, to: :post
  delegate :image_url, to: :photo

  # associations
  belongs_to :post
  belongs_to :photo

  # validations

  # callbacks

  # other
  def other_ziltaggings
    photo.ziltaggings.where.not(id: id)
  end

end
