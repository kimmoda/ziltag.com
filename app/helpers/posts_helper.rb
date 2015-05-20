module PostsHelper
  def summary content, options={}
    truncate sanitize(content, tags: %w[p]), {length: 250, escape: false}.merge!(options)
  end
end
