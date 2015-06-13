json.extract! @post, :id
json.ziltaggings do
  json.array! @post.ziltaggings, :id, :x, :y
end