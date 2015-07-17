json.results(@comments) do |comment|
  json.partial! 'comments/comment', comment: comment
  json.url comment_url(comment, format: :json)
  json.children do
    json.array! comment.latest_children, partial: 'comments/comment', as: :comment
  end
end
json.more !@comments.last_page?