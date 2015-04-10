json.results(@admin_users) do |admin_user|
  json.extract! admin_user, :id, :email
  json.text admin_user.email
end

json.pagination do
  json.more !@admin_users.last_page?
end
