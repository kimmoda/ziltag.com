# frozen_string_literal: true
json.extract! @user, :id, :email, :username, :confirmed?
json.avatar do
  json.url @user.avatar.url
  json.thumb @user.avatar.thumb.url
end
