class Ziltagging < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  # scopes
  scope :by_source, ->(source){ source.present? ? joins(:photo).where('photos.source = ?', source) : all }

  # constants

  # attributes
  delegate :title, :content, :user, to: :post
  delegate :image_url, to: :photo

  # associations
  has_many :tags, through: :post
  belongs_to :photo
  belongs_to :post,
    ->{ Rails.logger.warn 'Ziltagging#post is deprecated, use #ziltaggable instead.'; joins(:ziltaggings).where(ziltaggings: {ziltaggable_type: :Post}) },
    foreign_key: :ziltaggable_id
  belongs_to :ziltaggable, polymorphic: true

  # validations
  validates :ziltaggable, :photo, :x, :y, presence: true
  validates :ziltaggable_type, inclusion: {in: %w[Post]}

  # callbacks

  # other
  def post_id
    Rails.logger.warn 'Ziltagging#post is deprecated'
    ziltaggable.is_a?(Post) ? ziltaggable.id : nil
  end

  def other_ziltaggings
    photo.ziltaggings.where.not(id: id)
  end

  def as_indexed_json(options={})
    ziltaggable.respond_to?(:as_indexed_json) ? ziltaggable.as_indexed_json : ziltaggable.as_json
  end

end
