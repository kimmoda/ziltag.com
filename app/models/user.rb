class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # scopes

  # constants

  # attributes
  attr_accessor :login
  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  # associations
  has_many :ziltags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :ziltaggings, through: :posts
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :_followers, dependent: :destroy, class_name: Following, foreign_key: :leader_id
  has_many :_leaders, dependent: :destroy, class_name: Following, foreign_key: :follower_id
  has_many :followers, class_name: User, through: :_followers
  has_many :leaders, class_name: User, through: :_leaders
  has_many :collectings, dependent: :destroy
  has_many :collected_posts, through: :collectings, source: :collectable, source_type: Post

  # validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A\w+\z/}, if: :general_user?

  # callbacks

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
    email
  end

  def to_param
    username
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
end
