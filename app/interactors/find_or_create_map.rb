class FindOrCreateMap
  include Interactor

  def initialize(token, source, href, width, height)
    @token, @source, @href, @width, @height = token, source, href, width||0, height||0
    @box = Box.find_by(token: token)
  end

  def call
    fail! 'token not found' if @box.nil?
    url_regex = URI.regexp(['http', 'https'])
    fail! "source '#{@source}' is not a valid URL." unless @source =~ url_regex
    fail! "href '#{@href}' if nost a valid URL." unless @href =~ url_regex
    fail! "'#{@href}' is not permitted by given token '#{@token}'" unless @box.match_href? @href

    if photo = Photo.find_by_token_src_and_href(token: @token, source: @source, href: @href)
      context[:photo] = photo
    elsif photo = Photo.create(source: @source, href: @href, width: @width, height: @height, box: @box)
      photo.valid? ? context[:photo] = photo : fail!(photo.errors.full_messages.first)
    end
    PhotoJob.perform_later photo, photo.source unless photo.image?
  end
end