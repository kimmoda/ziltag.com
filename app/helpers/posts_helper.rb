module PostsHelper
  # TODO: 寫 test
  def summary content, length: 300, **options
    content = strip_tags(content)
    length -= content[0, length].scan(/\p{Han}/).size/2 - 1
    truncate content, {length: length}.merge!(options)
  end
end
