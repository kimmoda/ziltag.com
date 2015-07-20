json.extract! comment, :id, :text, :email, :x, :y, :comment_id, :photo_id, :created_at, :updated_at
if user = comment.user
  json.user do
    json.extract! user, :id, :email, :username
    json.avatar_thumb_url user.avatar.thumb.url
  end
else
  json.user nil
end