# TODO: duplicated: app/views/api/v1/users/sessions/create.json.jbuilder
json.extract! @user, :id, :email, :username, :confirmed?
json.avatar do
  json.url @user.avatar.url
  json.thumb @user.avatar.thumb.url
end