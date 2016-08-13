class Comment < ActiveRecord::Base
  include Confirmable
  # scopes
  default_scope ->{ order('comments.id desc') }

  # constants

  # attributes
  delegate :username, :confirmed?, to: :user

  # associations
  belongs_to :user
  belongs_to :ziltag
  has_many :siblings, ->(comment){ where.not(id: comment.id) }, through: :ziltag, source: :comments
  has_many :sibling_commenters, ->(comment){ where.not('users.id': comment.user_id) }, through: :siblings, source: :user

  # validations
  validates :ziltag, :user, :content, presence: true
  validates :content, length: { maximum: 5000 }

  # callbacks

  # other
  def to_s
    content
  end
end
