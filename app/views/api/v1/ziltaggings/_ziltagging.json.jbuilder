json.extract! ziltagging, :id, :post_id, :photo_id, :x, :y, :created_at, :updated_at

if controller_path == 'api/v1/ziltaggings'
  json.post do
    json.partial! ziltagging.post
  end

  json.photo do
    json.partial! ziltagging.photo
  end

  json.user do
    json.partial! ziltagging.user
  end
end