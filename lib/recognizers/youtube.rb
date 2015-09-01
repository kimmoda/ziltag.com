module Recognizers
  class YouTube
    attr_reader :video_id
    def initialize content
      @content = content
      @video_id = content[%r{www\.youtube\.com/watch\?v=([\w-]+)}, 1] || content[%r{youtu\.be/([\w-]+)}, 1]
    end

    def matched?
      !!@video_id
    end
  end
end