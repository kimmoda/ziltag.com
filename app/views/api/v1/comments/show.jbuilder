json.extract! @comment, :id, :content, :created_at
json.usr @comment.user, partial: 'api/v1/users/user', as: :user