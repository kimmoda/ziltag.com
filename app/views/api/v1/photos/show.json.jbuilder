json.extract! @photo, :id, :user_id, :source, :created_at, :updated_at
json.image do
  json.origin @photo.image.url
  json.thumb @photo.image.thumb.url
end
json.ziltaggings do
  json.partial! @photo.ziltaggings
end