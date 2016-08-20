# frozen_string_literal: true
class Partner < User
  validates :username, presence: true, on: :update
end
