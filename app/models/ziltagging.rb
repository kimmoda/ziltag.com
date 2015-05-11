class Ziltagging < ActiveRecord::Base
  # scopes

  # constants

  # attributes
  delegate :title, :content, :user, to: :post

  # associations
  belongs_to :post
  belongs_to :photo, foreign_key: :image_url, primary_key: :url

  # validations

  # callbacks

  # other

end
