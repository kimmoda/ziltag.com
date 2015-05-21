json.results(@admin_photos) do |admin_photo|
  json.id admin_photo.id
  json.text admin_photo.image_url
end

json.pagination do
  json.more !@admin_photos.last_page?
end
