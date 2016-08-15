# frozen_string_literal: true
json.id ziltag.slug
json.x ziltag.x.to_f
json.y ziltag.y.to_f
json.created_at ziltag.created_at
json.usr do
end
json.preview truncate(ziltag.content)
json.content ziltag.content
