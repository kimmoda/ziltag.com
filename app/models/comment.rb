class Comment < ActiveRecord::Base
  # scopes
  scope :where_image_url_is, ->(url){ joins(:photo).where(photos: {source: url}) }
  scope :is_root, ->{ where(root: nil) }

  # constants

  # attributes
  delegate :image_url, to: :photo

  # associations
  belongs_to :user, primary_key: :email, foreign_key: :email
  belongs_to :photo
  belongs_to :root, class_name: Comment, foreign_key: :comment_id
  has_many :children, ->{ order(:created_at) }, class_name: Comment

  # validations

  # callbacks

  # other
  def to_s
    text
  end
end
