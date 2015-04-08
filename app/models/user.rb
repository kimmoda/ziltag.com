class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # scopes

  # constants

  # attributes

  # associations

  # validations

  # callbacks

  # other

  def to_s
    email
  end
end