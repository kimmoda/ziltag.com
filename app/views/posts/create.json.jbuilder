json.partial! 'post', post: @post
if @ziltagging
  json.ziltagging do
    json.extract! @ziltagging, :id, :x, :y, :photo_id
  end
end