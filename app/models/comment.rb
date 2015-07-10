class Comment < ActiveRecord::Base
  # scopes
  scope :where_image_url_is, ->(url){ joins(:photo).where(photos: {source: url}) }
  scope :is_root, ->{ where(root: nil) }

  # constants

  # attributes
  delegate :image_url, to: :photo

  # associations
  belongs_to :user
  belongs_to :photo
  belongs_to :root, class_name: Comment, foreign_key: :comment_id
  has_many :children, ->{ order(:created_at) }, class_name: Comment
  has_many :latest_children, ->{ order(:created_at).limit(10) }, class_name: Comment

  # validations
  validates :photo, :text, presence: true
  validate :identity # either email or user exists
  validate :coordinates # either coordinates or comment_id should exists

  # callbacks
  before_validation :set_email_from_user
  before_validation :set_coordinates_from_root, if: :child?

  # other
  def to_s
    text
  end

  def child?
    root.present?
  end

private

  def identity
    unless email.present? || user.present?
      errors.add :base, 'either email or user should exists.'
    end
  end

  def coordinates
    unless root.present? || (x.present? && y.present?)
      errors.add :bases, 'either coordinates or comment_id should exists.'
    end
  end

  def set_email_from_user
    self.email = user.email if user.present?
  end

  def set_coordinates_from_root
    if root.present?
      self.x, self.y = root.x, root.y
    end
  end

end
