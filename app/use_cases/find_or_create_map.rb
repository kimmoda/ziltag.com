class FindOrCreateMap
  include UseCase

  def initialize(token, source, href, width, height)
    @token, @source, @href, @width, @height = token, source, href, width, height
    @box = Box.find_by(token: token)
  end

  def call
    errors[:token] = 'token not found' if @box.nil?
    url_regex = URI.regexp(['http', 'https'])
    errors[:source] = "source '#{@source}' is not a valid URL." unless @source =~ url_regex
    errors[:href] = "href '#{@href}' if nost a valid URL." unless @href =~ url_regex
    return unless success?
    errors[:token] = "'#{@href}' is not permitted by given token '#{@token}'" unless @box.match_href? @href
    return unless success?

    if photo = Photo.find_by_token_src_and_href(token: @token, source: @source, href: @href)
      results[:photo] = photo
    elsif photo = Photo.create(source: @source, href: @href, width: @width, height: @height, box: @box)
      photo.valid? ? results[:photo] = photo : errors[:photo_errors] = photo.errors.full_messages.first
    end
  end
end