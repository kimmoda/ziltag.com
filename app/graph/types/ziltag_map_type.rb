ZiltagMapType = GraphQL::ObjectType.define do
  name 'ZiltagMap'
  description 'A ziltag map entry'
  field :width, !types.Int
  field :height, !types.Int
  field :host, !types.String
  field :href, !types.String
  field :id, !types.String, property: :slug
  field :src, types.String, property: :source
  field :ziltags, types[!ZiltagType]
end