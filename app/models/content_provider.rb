class ContentProvider < User
  validates :username, presence: true, on: :update
end