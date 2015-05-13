json.array! ziltaggings do |ziltagging|
  json.extract! ziltagging, :id, :x, :y
  json.link url_for(ziltagging)
end