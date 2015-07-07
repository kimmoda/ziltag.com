json.array!(@comments) do |comment|
  json.extract! comment, :id, :text, :email, :x, :y, :comment_id, :photo_id
  json.url comment_url(comment, format: :json)
  json.children do
    json.array! comment.children
  end
end
