# frozen_string_literal: true
json.id @photo.natural_id
json.src @photo.image.default.url
json.host @photo.host
json.extract! @photo, :href, :width, :height
json.ziltags do
  json.array!(@photo.ziltags.confirmed.includes(:user)) do |ziltag|
    json.id ziltag.natural_id
    json.created_at ziltag.created_at
    json.x ziltag.x.to_f
    json.y ziltag.y.to_f
    json.usr ziltag.user, partial: 'api/v1/ziltags/user', as: :user
    json.content ziltag.content
  end
end
