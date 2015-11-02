json.extract! comment, :id, :content, :username
json.confirmed comment.confirmed?
json.avatar comment.user.avatar.thumb.url