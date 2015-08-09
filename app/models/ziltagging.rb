class Ziltagging < ActiveRecord::Base
  # scopes
  scope :by_source, ->(source){ source.present? ? joins(:photo).where('photos.source = ?', source) : all }

  def self.search query_string
    results = includes(:photo, :tags, post: :user).where(posts: {published: true}).order('ziltaggings.id DESC')
    if query_string.present?
      words = query_string.split(%r(\s,':\;!?")).join('|')
      results = results.where("tags.name ~* ? OR posts.title ~* ?", words, words)
    end
    results
  end

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

end
