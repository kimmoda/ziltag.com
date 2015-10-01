class Comment < ActiveRecord::Base
  # scopes
  default_scope ->{ order('id desc') }

  # constants

  # attributes
  delegate :username, :confirmed?, to: :user

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

  def notify_users
    users = ziltag.comments.includes(:user).map(&:user).reject!{|u| u == user } << ziltag.user
    users.uniq!
    users.each{ |user| NotificationMailer.new_comment_notification(user, self).deliver_later }
  end

end
