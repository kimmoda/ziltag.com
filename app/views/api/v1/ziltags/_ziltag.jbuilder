json.extract! ziltag, :id, :slug, :x, :y, :username
json.confirmed ziltag.confirmed?
json.content truncate(ziltag.content)