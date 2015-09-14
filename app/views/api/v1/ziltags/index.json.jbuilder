json.array!(@ziltags) do |ziltag|
  json.extract! ziltag, :id, :x, :y
  json.src ziltag.source
  json.usr ziltag.username
  json.preview truncate ziltag.content
end
