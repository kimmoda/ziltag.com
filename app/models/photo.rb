# frozen_string_literal: true
require 'tumblr_identifier'
class Photo < ActiveRecord::Base #:nodoc:
  BLOGSPOT_DOMAINS = %w(
    com ae am be bg ca ch co.at co.il co.ke co.nz co.uk cz de dk fi fr hk ie in
    is it jp kr li lt lu md mx nl no pe ro rs ru se sg si sk sn tw ug
  ).map! { |c| 'blogspot.' + c }.freeze

  include Natural

  # scopes

  def self.without_tags
    joins('LEFT JOIN ziltags ON ziltags.photo_id = photos.id')
      .where('ziltags.photo_id is NULL')
  end

  # TODO: this can be improved by adding a column for couting cache
  def self.having_tags_more_than(number = 1)
    joins(ziltags: :user).where.not(users: { confirmed_at: nil })
                         .group('photos.id')
                         .having('count(photos.id) > ?', number).uniq
  end

  # TODO: SQL can be improved
  def self.recommended
    joins(ziltags: :user).where(id: having_tags_more_than.select(:id))
                         .where.not('users.username = ?', 'ziltag')
                         .order('ziltags.created_at DESC').to_a.uniq.first(100)
  end

  def self.find_by_token_src_and_href(token:, source:, href:)
    uri = URI(href)
    host = uri.host
    scope = Photo.joins(:website).where(websites: { token: token })
    scope = if host.end_with?(*BLOGSPOT_DOMAINS)
              blog_id = host.split('.').first
              scope.where(source: source).in_blogspot(blog_id)
            elsif tumblr_image_id = TumblrIdentifier.identify(source)
              scope.in_tumblr(tumblr_image_id)
            else
              scope.where(host: host, source: source)
            end
    scope.take
  end

  def self.in_blogspot(blog_id)
    where(
      'host LIKE ANY (array[?])',
      BLOGSPOT_DOMAINS.map { |c| "#{blog_id}.#{c}" }
    )
  end

  # TODO: performance can be improved by indexing source path
  def self.in_tumblr(tumblr_image_id)
    where('source LIKE ?', "%#{tumblr_image_id}%")
  end

  # constants

  # attributes
  mount_uploader :image, ImageUploader
  delegate :token, :user, to: :website

  # associations
  belongs_to :website
  has_many :ziltags, dependent: :destroy

  # validations
  validates :href, format: /\A#{URI.regexp}\z/, allow_nil: true
  validates :width, :height, presence: true

  # callbacks

  # other

  def to_param
    natural_id
  end

  def to_s
    read_attribute(:image)
  end

  def href=(value)
    super
    if href =~ /\A#{URI.regexp}\z/
      uri = URI(href)
      self.host = uri.host
      self.path = uri.path
    else
      logger.warn "invalid URI format: #{value}"
    end
  end
end
