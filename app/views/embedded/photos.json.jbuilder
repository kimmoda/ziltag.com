json.array! @photos do |photo|
  json.q @url_hash[photo.source]
  json.ziltaggings photo.ziltaggings do |ziltagging|
    json.extract! ziltagging, :x, :y
    json.link embedded_ziltagging_url(ziltagging)
  end
end