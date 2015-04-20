class Comment < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user, primary_key: :email, foreign_key: :email
  belongs_to :root, class_name: Comment, foreign_key: :comment_id
  has_many :children, class: Comment, foreign_key: :comment_id

  # validations

  # callbacks

  # other
  def to_s
    text
  end
end
