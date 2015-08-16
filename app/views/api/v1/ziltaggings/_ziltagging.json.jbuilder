json.extract! ziltagging, :id, :post_id, :photo_id, :x, :y, :ziltaggable_type, :created_at, :updated_at

if controller_path == 'api/v1/ziltaggings'
  json.ziltaggable do
    json.partial! ziltagging.ziltaggable
  end

  json.post do
    json.warn 'This field is deprecated in order to supprt multiple sticker types. Use "ziltaggable_type", ane "ziltaggable" instead.'
    json.partial! ziltagging.post
  end

  json.photo do
    json.partial! ziltagging.photo
  end

  json.user do
    json.partial! ziltagging.user
  end
end