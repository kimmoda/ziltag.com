class Box < ActiveRecord::Base
  BLOGSPOT_DOMAINS = %w[com ae am be bg ca ch co.at co.il co.ke co.nz co.uk cz de dk fi fr hk ie in is it jp kr li lt lu md mx nl no pe ro rs ru se sg si sk sn tw ug].map!{|c| 'blogspot.' << c}.freeze

  # scopes

  # constants

  # attributes

  # associations
  belongs_to :user
  has_many :photos, dependent: :destroy do
    def find_or_create_by_source_and_uri! source, href
      uri = URI(href)
      host = uri.host
      subdomains = host.split('.')
      photo = if host.end_with?(*BLOGSPOT_DOMAINS)
        find_by('host LIKE ANY (array[?])', BLOGSPOT_DOMAINS.map{|c| "#{subdomains.first}.#{c}" })
      else
        find_by(host: host)
      end
      photo || create!(source: source, href: href)
    end
  end

  # validations
  validates :user, :token, presence: true
  validates :token, uniqueness: true

  # callbacks
  before_validation :assign_token, if: -> { token.blank? }

  # other
  def assign_token
    loop do
      self.token = SecureRandom.hex(3)
      break unless self.class.exists? token: token
    end
  end

  def service
    return nil if url.blank?
    uri = URI(url)
    if uri.host.end_with? 'tumblr.com' then 'tumblr'
    elsif uri.host.end_with? 'wordpress.com' then 'wordpress'
    elsif uri.host.end_with? 'logdown.com' then 'logdown'
    elsif uri.host.end_with? 'pixnet.net' then 'pixnet'
    elsif uri.host.end_with? *BLOGSPOT_DOMAINS then 'blogger'
    elsif uri.host == 'blog.xuite.net' then 'xuite'
    else nil
    end
  end

end
