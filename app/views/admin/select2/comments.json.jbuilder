json.results(@comments) do |comment|
  json.id comment.id
  json.text comment.text
end

json.pagination do
  json.more !@comments.last_page?
end
