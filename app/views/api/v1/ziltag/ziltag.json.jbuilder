json.photo do
  json.partial! @ziltag.photo
end

json.post do
  json.partial! @ziltag.post
end

json.ziltagging do
  json.partial! @ziltag.ziltagging
end