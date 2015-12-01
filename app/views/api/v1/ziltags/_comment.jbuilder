json.extract! comment, :id, :content
json.usr comment.user, partial: 'api/v1/ziltags/user', as: :user
