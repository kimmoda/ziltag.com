json.array!(@photos) do |photo|
  json.extract! photo, :id, :user_id, :source
  json.url photo_url(photo, format: :json)
  json.image do
    json.origin photo.image.url
    json.thumb photo.image.thumb.url
  end
  json.ziltaggings do
    json.partial! photo.ziltaggings
  end
end
