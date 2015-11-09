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
  after_create :notify_create
  after_update :notify_update, if: :content_changed?

  # other
  def to_s
    content
  end

  def notify_users
    users = ziltag.comments.includes(:user).map(&:user) << ziltag.user
    users.reject!{|u| u == user || !u.notification }
    users.uniq!
    users.each{ |user| NotificationMailer.new_comment_notification(user, self).deliver_later }
  end

private

  def notify_stream action
    Ziltag.connection.execute "NOTIFY #{action}_comment, '#{id}'" if content_changed?
  end

  def notify_create
    notify_stream 'create'
  end

  def notify_update
    notify_stream 'update'
  end

end
