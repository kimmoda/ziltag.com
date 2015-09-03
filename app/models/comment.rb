class Comment < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  belongs_to :sticker

  # validations
  validates :sticker, :user, :content, presence: true

  # callbacks

  # other
  def to_s
    content
  end

end
