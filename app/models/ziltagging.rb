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
  belongs_to :post
  belongs_to :photo

  # validations
  validates :post, :photo, :x, :y, presence: true

  # callbacks

  # other
  def other_ziltaggings
    photo.ziltaggings.where.not(id: id)
  end

  def as_indexed_json(options={})
    post.as_indexed_json
  end

end
