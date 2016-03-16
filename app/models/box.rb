# frozen_string_literal: true
require 'tumblr_identifier'
class Box < ActiveRecord::Base
  BLOGSPOT_DOMAINS = %w[com ae am be bg ca ch co.at co.il co.ke co.nz co.uk cz de dk fi fr hk ie in is it jp kr li lt lu md mx nl no pe ro rs ru se sg si sk sn tw ug].map!{|c| 'blogspot.' + c}.freeze
  PLATFORMS = {
    'tumblr.com' => 'tumblr',
    'wordpress.com' => 'wordpress',
    'logdown.com' => 'logdown',
    'pixnet.net' => 'pixnet',
    'blog.xuite.net' => 'xuite',
    BLOGSPOT_DOMAINS => 'blogger',
  }
  DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}\z/i

  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :photos, dependent: :destroy do
    def find_or_create_by_source_and_uri! source, href, **create_options
      uri = URI(href)
      host = uri.host
      subdomains = host.split('.')
      photo = if host.end_with?(*BLOGSPOT_DOMAINS)
        where('host LIKE ANY (array[?])', BLOGSPOT_DOMAINS.map{|c| "#{subdomains.first}.#{c}" }).find_by(source: source)
      elsif tumblr_src_id = TumblrIdentifier.identify(source)
        where('source LIKE ?', "%#{tumblr_src_id}%").find_by(host: host) # TODO: performance can be improved by indexing source path
      else
        find_by(host: host, )
      end
      photo || create!(source: source, href: href, **create_options)
    end
  end

  # validations
  validates :user, :token, presence: true
  validates :token, uniqueness: true
  validate :url_must_be_valid

  # callbacks
  before_validation :assign_token, if: -> { token.blank? }

  # other
  def to_s
    token
  end

  def assign_token
    loop do
      self.token = SecureRandom.hex(3)
      break unless self.class.exists? token: token
    end
  end

  def host_name
    URI(url).host || url
  end

  def service
    return nil if url.blank?
    PLATFORMS.each do |tail, name|
      return name if host_name.end_with?(*tail)
    end
    nil
  end

  def match_href? href
    case service
    when 'blogger'
      URI(href).host.split('.').first == host_name.split('.').first
    else
      URI(href).host == host_name
    end
  end

  private

  def url_must_be_valid
    case url
    when URI.regexp(%w[http https]), DOMAIN_REGEX, nil
    else
      errors.add(:url, I18n.t('activerecord.errors.models.box.attributes.url.invalid'))
    end
  end

end
