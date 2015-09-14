json.array!(@ziltags) do |ziltag|
  json.id ziltag.slug
  json.map ziltag.photo.slug
  json.extract! ziltag, :x, :y
  json.usr ziltag.username
  json.preview truncate ziltag.content
end
