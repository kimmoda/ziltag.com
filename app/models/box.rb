class Box < ActiveRecord::Base
  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :photos, dependent: :destroy

  # validations
  validates :user, :token, presence: true
  validates :token, uniqueness: true

  # callbacks
  before_validation :assign_token, if: -> { token.blank? }

  # other
  def assign_token
    loop do
      self.token = SecureRandom.hex(3)
      break unless self.class.exists? token: token
    end
  end

end
