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
  after_create :notify_create
  after_update :notify_update, if: :content_changed?
  after_destroy :notify_destroy

  # other
  def to_s
    content
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
    notify_stream 'delete', {_slug: ziltag.slug, id: id}
  end

end
