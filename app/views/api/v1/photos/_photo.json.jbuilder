json.extract! photo, :id, :user_id, :source, :created_at, :updated_at

json.image do
  json.origin photo.image.url
  json.thumb photo.image.thumb.url
end

if controller_path == 'api/v1/photos'
  json.ziltaggings do
    json.partial! photo.ziltaggings
  end
end