module PostsHelper
  def summary content, length: 250, **options
    paragraphs = sanitize(content, tags: %w[p]).scan(/<p>(.*?)<\/p>/).map!(&:first)
    paragraphs = [content] if paragraphs.blank?
    ready_paragraphs = []
    total_length = 0
    paragraphs.each do |paragraph|
      ready_paragraphs << paragraph
      break if total_length + paragraph.length > length
      total_length += paragraph.length
    end
    truncate_options = {length: (length - total_length)}.merge!(options)
    ready_paragraphs.last.replace(truncate(ready_paragraphs.last, truncate_options))
    ready_paragraphs.map!{|x| "<p>#{x}</p>"}.join.html_safe
  end
end
