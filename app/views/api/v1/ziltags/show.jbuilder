json.extract! @ziltag, :id, :slug, :x, :y, :content

json.user do
  json.extract! @ziltag.user, :id, :username, :confirmed?
  json.avatar @ziltag.user.avatar.thumb.url
end

json.photo do
  json.extract! @ziltag.photo, :id, :slug, :href, :host, :path
  json.image @ziltag.photo.image.url
  json.siblings @ziltag.photo.ziltags.includes(:user).confirmed(current_user).where.not(id: @ziltag), partial: 'ziltag', as: 'ziltag'
end

json.comments @ziltag.comments.includes(:user).confirmed(current_user), partial: 'comment', as: :comment