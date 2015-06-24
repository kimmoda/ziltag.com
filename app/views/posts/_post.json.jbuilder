json.extract! post, :id, :title, :content, :published
json.created_on l(post.created_at, format: :date)
json.summary summary(post.content)
if first_photo = post.photos.first
  json.first_photo do
    json.extract! first_photo, :id, :image_url
    json.thumb first_photo.image.thumb.url
    json.ziltaggings do
      json.array! first_photo.ziltaggings, :id, :x, :y, :post_id
    end
  end
end