# frozen_string_literal: true
module Natural
  extend ActiveSupport::Concern

  included do
    before_create :generate_natural_id, if: -> { natural_id.blank? }
  end

  def generate_natural_id
    loop do
      self.natural_id = SecureRandom.hex(3)
      break unless self.class.exists? natural_id: natural_id
    end
  end
end
