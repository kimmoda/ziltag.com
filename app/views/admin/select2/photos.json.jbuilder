json.results(@photos) do |photo|
  json.id photo.id
  json.text photo.image_url
end

json.pagination do
  json.more !@photos.last_page?
end
