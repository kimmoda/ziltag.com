json.results(@admin_users) do |admin_user|
  json.id admin_user.id
  json.text admin_user.email
end

json.pagination do
  json.more !@admin_users.last_page?
end
