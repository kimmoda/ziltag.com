# frozen_string_literal: true
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # scopes

  def self.find_for_database_authentication(sign_in: nil, username: nil, email: nil, **conditions)
    if sign_in
      where(conditions).where(['lower(username) = lower(:value) OR lower(email) = :value', { value: sign_in.downcase }]).first
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
  has_many :websites, dependent: :destroy
  has_many :photos, through: :websites, dependent: :destroy

  # validations
  validates :username, uniqueness: { case_sensitive: false }, format: { with: /\A\w+\z/ }, length: { maximum: 30, minimum: 6 }, allow_nil: true
  validates :username, presence: true, if: :general_user?

  # callbacks

  # other

  def own?(record)
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

  def partner?
    type == 'Partner'
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later(wait: 5.seconds)
  end

  def website
    websites.first
  end

  def send_on_create_confirmation_instructions
    # override to do nothing to prevent send confirmatil email from devise.
  end
end
