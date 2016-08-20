# frozen_string_literal: true
class ContentProvider < User
  validates :username, presence: true, on: :update
end
