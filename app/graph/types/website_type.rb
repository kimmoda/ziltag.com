WebsiteType = GraphQL::ObjectType.define do
  name 'Website'
  description 'A website entry'
  field :id, !types.ID
  field :token, !types.String
  field :user, !UserType
  field :url, !types.String, property: :url_with_http
  field :restricted, !types.Boolean
  field :platform, !types.String
  field :comments, types[!CommentType]
  field :ziltags, types[!ZiltagType]
  field :maps_without_tags, ->{ types[!ZiltagMapType] } do
    resolve ->(obj, _args, _ctx){ obj.photos.without_tags.limit(100) }
  end
end
