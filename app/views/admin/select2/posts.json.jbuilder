json.results(@posts) do |post|
  json.id post.id
  json.text post.title
end

json.pagination do
  json.more !@posts.last_page?
end
