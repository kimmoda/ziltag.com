module Slugable
  extend ActiveSupport::Concern

  included do
    after_initialize :generate_slug, if: -> { slug.blank? }
  end

  def generate_slug
    loop do
      self.slug = SecureRandom.hex(3)
      break unless self.class.exists? slug: slug
    end
  end

end