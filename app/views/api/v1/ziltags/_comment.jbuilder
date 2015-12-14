json.extract! comment, :id, :content, :created_at
json.usr comment.user, partial: 'api/v1/ziltags/user', as: :user
