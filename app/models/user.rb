class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # scopes

  def self.find_for_database_authentication(sign_in: nil, username: nil, email: nil, **conditions)
    if sign_in
      where(conditions).where(["lower(username) = lower(:value) OR lower(email) = :value", { :value => sign_in.downcase }]).first
    elsif username || email
      where(conditions).first
    end
  end

  # constants

  # attributes
  attr_accessor :sign_in, :url
  mount_uploader :avatar, AvatarUploader

  # associations
  has_many :ziltags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :boxes, dependent: :destroy, after_remove: :nullify_box
  has_many :photos, dependent: :destroy

  # validations
  validates :username, uniqueness: {case_sensitive: false}, format: {with: /\A\w+\z/}, length: {maximum: 30, minimum: 6}, allow_nil: true
  validates :username, presence: true, if: :general_user?
  validates :password, confirmation: true
  validate :url_must_be_valid

  # callbacks
  after_find :set_box_url
  after_create :create_box!, if: :content_provider?
  after_update :save_box_url

  # other

  def own? record
    record.respond_to?(:user) && record.user == self
  end

  def to_s
    "#{username} <#{email}>"
  end

  def password_required?
    confirmed? ? super : false
  end

  def general_user?
    type.blank?
  end

  def content_provider?
    type == 'ContentProvider'
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later(wait: 5.seconds)
  end

  def box
    @box ||= boxes.first || create_box!
  end

  private

  def set_box_url
    @url = box.url
  end

  def create_box!
    boxes.create!
  end

  def save_box_url
    box.url = @url
    box.save if box.url_changed?
  end

  def nullify_box box
    @box = nil if box == @box
  end

  def url_must_be_valid
    case url
    when URI.regexp(%w[http https]), Box::DOMAIN_REGEX, nil
    else
      errors.add(:url, I18n.t('activerecord.errors.models.box.attributes.url.invalid'))
    end
  end

end
