json.array!(@comments) do |comment|
  json.partial! 'comments/comment', comment: comment
  json.extract! comment, :id, :text, :email, :x, :y, :comment_id, :photo_id
  json.children do
    json.array! comment.children, partial: 'comments/comment', as: :comment
  end
end
