json.results(@admin_comments) do |admin_comment|
  json.id admin_comment.id
  json.text "#{admin_comment.text} by #{admin_comment.email}"
end

json.pagination do
  json.more !@admin_comments.last_page?
end
