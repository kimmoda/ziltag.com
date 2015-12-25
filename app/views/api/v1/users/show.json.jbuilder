json.usr do
  json.name @user.username
  json.avatar @user.avatar.thumb.url
  json.confirmed @user.confirmed?
  json.email @user.email
end