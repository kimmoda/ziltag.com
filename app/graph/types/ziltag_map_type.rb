# frozen_string_literal: true
ZiltagMapType = GraphQL::ObjectType.define do
  name 'ZiltagMap'
  description 'A ziltag map entry'
  field :width, !types.Int
  field :height, !types.Int
  field :host, !types.String
  field :href, !types.String
  field :id, !types.String, property: :slug
  field :src, !types.String do
    resolve ->(obj, _args, _ctx) { obj&.image&.default&.url }
  end
  field :ziltags, types[!ZiltagType]
  field :website, WebsiteType do
    resolve ->(obj, _args, _ctx) { obj.box }
  end
end
