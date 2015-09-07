json.array!(@stickers) do |sticker|
  json.extract! sticker, :id, :x, :y, :content, :source, :username
end
