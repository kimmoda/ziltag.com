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

  # validations
  validates :ziltag, :user, :content, presence: true

  # callbacks

  # other
  def to_s
    content
  end

  def notify_users
    users = ziltag.comments.includes(:user).map(&:user) << ziltag.user
    users.reject!{|u| u == user }
    users.uniq!
    users.each{ |user| NotificationMailer.new_comment_notification(user, self).deliver_later }
  end

end
