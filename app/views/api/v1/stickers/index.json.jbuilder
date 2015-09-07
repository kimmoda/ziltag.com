json.array!(@stickers) do |sticker|
  json.extract! sticker, :id, :x, :y, :content, :source, :username
  json.link photo_url(source: sticker.photo.source, sticker_id: sticker.id)
end
