json.array!(@ziltaggings) do |ziltagging|
  json.extract! ziltagging, :id, :post_id, :photo_id, :x, :y
  json.url ziltagging_url(ziltagging, format: :json)
end
