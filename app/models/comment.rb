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
  after_destroy :notify_destroy

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

  def notify_stream action, payload
    Ziltag.connection.execute "NOTIFY #{action}_comment, '#{payload.to_json.gsub("'", "''")}'"
  end

  def notify_create
    notify_stream :create, sse_json
  end

  def notify_update
    notify_stream :update, sse_json
  end

  def sse_json
    {
      _slug: ziltag.slug,
      id: id,
      content: content,
      created_at: created_at,
      usr: {
        avatar: user.avatar.thumb.url,
        name: user.username
      }
    }
  end

  def notify_destroy
    notify_stream 'delete', {_slug: ziltag.slug, slug: ziltag.slug, id: id}
  end

end
