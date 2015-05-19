json.extract! @ziltagging, :id, :x, :y, :image_url
json.created_at l(@ziltagging.created_at, format: :long)
json.link url_for(@ziltagging)

json.location do
  json.name 'TODO: Ziltag 微廣科技總部'
  json.address 'TODO: 台北市內湖區瑞光路192號'
end

json.post do
  json.extract! @ziltagging.post, :id, :title, :content
end

json.user do
  json.extract! @ziltagging.user, :id, :username
  json.avatar  @ziltagging.user.avatar.thumb.url
end

json.other_ziltaggings do
  json.partial! 'ziltaggings', ziltaggings: @other_ziltaggings
end

json.following_button following_button(@ziltagging.user)