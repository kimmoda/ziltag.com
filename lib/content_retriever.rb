require 'uri'
Dir[File.dirname(__FILE__) + '/recognizers/*.rb'].each {|file| require file }
class ContentRetriever
  include Recognizers

  RECOGNIZERS = [YouTube, Twitter]

  attr_reader :content, :recognizer

  def initialize content
    @content = content
    RECOGNIZERS.each do |recognizer_class|
      recognizer = recognizer_class.new(@content)
      if recognizer.matched?
        @recognizer = recognizer
        break
      end
    end
  end
end