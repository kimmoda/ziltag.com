# frozen_string_literal: true
require 'data_url'
class FindOrCreateMap < Interactor2
  attr_reader :photo

  def initialize(token, source, href, width, height, namespace = nil)
    @token = token
    @source = source
    @href = href
    @width = width || 0
    @height = height || 0
    @website = Website.find_by(token: token)
    @namespace = namespace
  end

  def perform
    fail! 'token not found' if @website.nil?
    url_regex = URI.regexp(%w(http https))
    fail! "source '#{@source}' is not a valid URL." unless @source =~ url_regex || @source =~ DataURL::PARSER
    fail! "href '#{@href}' if nost a valid URL." unless @href =~ url_regex
    fail! "'#{@href}' is not permitted by given token '#{@token}'" unless @website.match_href? @href

    if photo = Photo.find_by_token_src_and_href(token: @token, source: @source, href: @href, namespace: @namespace)
      @photo = photo
    elsif photo = Photo.create(source: @source, href: @href, width: @width, height: @height, website: @website, namespace: @namespace)
      photo.persisted? ? @photo = photo : fail!(photo.errors.full_messages.first)
    end
    PhotoJob.perform_later photo, photo.source unless photo.image?
  end
end
