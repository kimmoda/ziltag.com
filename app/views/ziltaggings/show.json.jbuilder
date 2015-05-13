json.extract! @ziltagging, :id, :x, :y
json.link url_for(@ziltagging)
json.post do
  json.extract! @ziltagging.post, :id, :title, :content
end
json.user do
  json.extract! @ziltagging.user, :id, :username
  json.avatar  @ziltagging.user.avatar.thumb.url
end
