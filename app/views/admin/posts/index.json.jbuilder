json.results(@admin_posts) do |admin_post|
  json.id admin_post.id
  json.text admin_post.title
end

json.pagination do
  json.more !@admin_posts.last_page?
end
