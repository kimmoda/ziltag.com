json.map @photo.slug
json.src @photo.image.default.url
json.href @photo.href
json.ziltags do
  json.array!(@photo.ziltags.confirmed.includes(:user)) do |ziltag|
    json.id ziltag.slug
    json.x ziltag.x.to_f
    json.y ziltag.y.to_f
    json.usr ziltag.username
    json.preview truncate raw ziltag.content
  end
end
