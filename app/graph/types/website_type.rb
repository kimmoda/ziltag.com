WebsiteType = GraphQL::ObjectType.define do
  name 'Website'
  description 'A website entry'
  field :id, !types.ID
  field :token, !types.String
  field :user, !UserType
  field :url, !types.String, property: :url_with_http
  field :platform, !types.String
end