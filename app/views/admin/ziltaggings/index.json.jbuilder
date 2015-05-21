json.array!(@admin_ziltaggings) do |admin_ziltagging|
  json.extract! admin_ziltagging, :id, :x, :y, :image_url
  json.link admin_post_path(admin_ziltagging.post)
end
