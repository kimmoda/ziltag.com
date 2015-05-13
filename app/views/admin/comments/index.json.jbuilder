json.results(@admin_comments) do |admin_comment|
  json.extract! admin_comment, :id, :text, :image_url, :x, :y
  json.avatar (admin_comment.user || User.new).avatar.thumb.url
end

json.pagination do
  json.more !@admin_comments.last_page?
end
