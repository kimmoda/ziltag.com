class Ziltag < ActiveRecord::Base
  include Slugable
  # scopes
  scope :confirmed, ->{ joins(:user).where('users.confirmed_at IS NOT NULL') }

  # constants

  # attributes
  delegate :source, to: :photo
  delegate :username, :confirmed?, to: :user

  # associations
  belongs_to :photo
  belongs_to :user
  has_many :comments, dependent: :destroy

  # validations

  # callbacks

  # other
  def to_param
    slug
  end
end
