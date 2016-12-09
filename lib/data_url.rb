# RFC2397
# dataurl    := "data:" [ mediatype ] [ ";base64" ] "," data
# mediatype  := [ type "/" subtype ] *( ";" parameter )
# data       := *urlchar
# parameter  := attribute "=" value
require 'base64'
require 'mime/types'
require 'securerandom'
class DataURL
  PARSER = %r{data:(?<mime>\w+/\w+)(?<base64>;base64)?,(?<data>.*)}

  class Error < RuntimeError; end
  class InvalidDataURL < Error; end

  attr_reader :data, :mime, :ext, :filename

  def initialize(url)
    raise InvalidDataURL unless match_data = PARSER.match(url)
    @url = url
    @mime = MIME::Types[match_data[:mime]].first
    @data = if match_data[:base64]
                ::Base64.decode64(URI.unescape(match_data[:data]))
              else
                match_data[:data]
              end
  end

  def ext
    @ext ||= mime.preferred_extension
  end

  def filename
    @filename ||= "#{SecureRandom.hex(3)}.#{ext}"
  end

  # used with carrierwave
  def to_string_io
    string_io = StringIO.new(data)
    string_io.instance_variable_set :@_filename, filename
    def string_io.original_filename; @_filename; end
    string_io
  end
end
