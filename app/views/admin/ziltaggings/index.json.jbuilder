json.array!(@admin_ziltaggings) do |admin_ziltagging|
  json.extract! admin_ziltagging, :id, :x, :y, :image_url, :title
  json.link admin_post_url(admin_ziltagging.post)
end
