json.array!(@ziltags) do |ziltag|
  json.extract! ziltag, :id, :x, :y, :content, :source, :username
  json.link photo_url(source: ziltag.photo.source, ziltag_id: ziltag.id)
end
