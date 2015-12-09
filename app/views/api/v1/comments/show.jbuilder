json.extract! @comment, :id, :content
json.usr @comment.user, partial: 'api/v1/users/user', as: :user