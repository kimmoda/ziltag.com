json.results(@admin_comments) do |admin_comment|
  json.extract! admin_comment, :id, :text, :image_url, :x, :y
  json.link admin_comment_path(admin_comment)
  json.avatar admin_comment.user ? admin_comment.user.avatar.thumb.url : nil
end

json.pagination do
  json.more !@admin_comments.last_page?
end
