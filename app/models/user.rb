class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # scopes

  # constants

  # attributes
  mount_uploader :avatar, AvatarUploader

  # associations
  has_many :posts
  has_many :photos
  has_many :comments, as: :commentable

  # validations
  validates :email, presence: true

  # callbacks

  # other

  def to_s
    email
  end
end
