json.id @photo.slug
json.src @photo.image.default.url
json.extract! @photo, :href, :width, :height
json.ziltags do
  json.array!(@photo.ziltags.confirmed.includes(:user)) do |ziltag|
    json.id ziltag.slug
    json.x ziltag.x.to_f
    json.y ziltag.y.to_f
    json.usr ziltag.user, partial: 'api/v1/ziltags/user', as: :user
    json.preview truncate raw ziltag.content
  end
end
