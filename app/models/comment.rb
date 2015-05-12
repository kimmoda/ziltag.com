class Comment < ActiveRecord::Base
  # scopes

  # constants
  GUEST_AVATAR = "#{Rails.configuration.asset_host}/images/fallback/tiny_guest.png".freeze

  # attributes

  # associations
  belongs_to :user, primary_key: :email, foreign_key: :email
  belongs_to :root, class_name: Comment, foreign_key: :comment_id
  has_many :children, class_name: Comment

  # validations

  # callbacks

  # other
  def to_s
    text
  end

  def avatar_url
    user ? user.avatar.thumb.url : GUEST_AVATAR
  end
end
