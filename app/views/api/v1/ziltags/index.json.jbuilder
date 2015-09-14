json.array!(@ziltags) do |ziltag|
  json.uuid ziltag.slug
  json.extract! ziltag, :x, :y
  json.usr ziltag.username
  json.preview truncate ziltag.content
end
