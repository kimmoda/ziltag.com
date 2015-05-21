json.results(@admin_comments) do |admin_comment|
  json.extract! admin_comment, :id, :text, :x, :y
  json.image_url admin_comment.photo.image_url
  json.avatar (admin_comment.user || User.new).avatar.thumb.url
end

json.pagination do
  json.more !@admin_comments.last_page?
end
