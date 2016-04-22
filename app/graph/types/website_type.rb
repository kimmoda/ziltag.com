WebsiteType = GraphQL::ObjectType.define do
  name 'Website'
  description 'A website entry'
  field :id, !types.ID
  field :token, !types.String
  field :user, !UserType
  field :url, !types.String
  field :platform, !types.String
end