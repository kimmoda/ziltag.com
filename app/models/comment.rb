class Comment < ActiveRecord::Base
  # scopes
  default_scope ->{ order('id desc') }

  # constants

  # attributes

  # associations
  belongs_to :user
  belongs_to :ziltag

  # validations
  validates :ziltag, :user, :content, presence: true

  # callbacks

  # other
  def to_s
    content
  end

end
