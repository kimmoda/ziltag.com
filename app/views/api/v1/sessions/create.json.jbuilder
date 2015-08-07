json.extract! @user, :id, :email, :username
json.avatar do
  json.origin @user.avatar.url
  json.thumb @user.avatar.thumb.url
end
json.cover do
  json.origin @user.cover.url
  json.default @user.cover.default.url
  json.thumb @user.cover.thumb.url
end