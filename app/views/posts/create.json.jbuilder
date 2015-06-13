json.extract! @post, :id, :title, :content
if @ziltagging
  json.ziltagging do
    json.extract! @ziltagging, :id, :x, :y, :photo_id
  end
end