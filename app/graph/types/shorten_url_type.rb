# frozen_string_literal: true
ShortenURLType = GraphQL::ObjectType.define do
  name 'Shorten URL'
  field :id, !types.ID, property: :natural_id
  field :url, !types.String
end
