class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # scopes
  scope :hot_users, ->{ all }

  # constants

  # attributes
  attr_accessor :login
  mount_uploader :avatar, AvatarUploader
  mount_uploader :cover, CoverUploader

  # associations
  has_many :posts
  has_many :ziltaggings, through: :posts
  has_many :photos
  has_many :comments, primary_key: :email, foreign_key: :email
  has_many :_followers, class_name: Following, foreign_key: :leader_id
  has_many :_leaders, class_name: Following, foreign_key: :follower_id
  has_many :followers, class_name: User, through: :_followers
  has_many :leaders, class_name: User, through: :_leaders
  has_many :collectings
  has_many :collected_posts, through: :collectings, source: :collectable, source_type: Post

  # validations
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}

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

  def follow? leader
    leaders.index(leader) != nil
  end

  def follow! leader
    leaders << leader unless follow?(leader)
  end

  def unfollow! leader
    leaders.delete(leader) if follow?(leader)
  end

  def collect? record
    collectings.index{|c| c.collectable == record } != nil
  end

  def collect! record
    collectings.create!(collectable: record) unless collectings.exists? collectable: record
  end

  def uncollect! record
    collectings.destroy collectings.find_by(collectable: record) if collectings.exists? collectable: record
  end

  def to_s
    email
  end

  def to_param
    username
  end
end
