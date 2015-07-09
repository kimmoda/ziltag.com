json.partial! 'comments/comment', comment: @comment
json.children do
  json.array! @comment.children, partial: 'comments/comment', as: :comment
end