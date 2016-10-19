# frozen_string_literal: true
json.usr do
  json.name @user.username
  json.avatar @user.avatar.thumb.url
  json.confirmed @user.confirmed?
  json.email @user.email
  json.permissions @permissions
end
json.permissions @permissions
