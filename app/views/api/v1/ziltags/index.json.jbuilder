json.map @photo.slug
json.ziltags do
  json.array!(@photo.ziltags.confirmed.includes(:user)) do |ziltag|
    json.id ziltag.slug
    json.extract! ziltag, :x, :y
    json.usr ziltag.username
    json.preview truncate raw ziltag.content
  end
end
