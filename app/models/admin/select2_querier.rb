class Admin::Select2Querier
  ATTRIBUTES = ActiveSupport::HashWithIndifferentAccess.new(
    posts: :title, users: :username, photos: :source, comments: :text
  )

  attr_accessor :plural

  def initialize plural
    @plural = plural.to_s
  end

  def model_class
    @plural.to_s.classify.constantize
  end

  def search_column
    ATTRIBUTES[@plural] || raise("undefined plural: #{@plural}")
  end

  def query q
    model_class.where("#{search_column} ILIKE ?", "%#{q}%")
  end
end