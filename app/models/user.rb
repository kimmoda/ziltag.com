class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # scopes

  # constants

  # attributes
  attr_accessor :login
  mount_uploader :avatar, AvatarUploader

  # associations
  has_many :ziltags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :boxes, dependent: :destroy

  # validations
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A\w+\z/}, if: :general_user?

  # callbacks
  after_create :create_box!, if: :content_provider?

  # other
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    ret = if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = lower(:value) OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
    ret
  end

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
    devise_mailer.send(notification, self, *args).deliver_later
  end if Rails.env.production?

  def box
    boxes.first || create_box!
  end

private

  def create_box!
    boxes.create!
  end

end
