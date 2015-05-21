json.results(@users) do |user|
  json.id user.id
  json.text user.username
end

json.pagination do
  json.more !@users.last_page?
end
