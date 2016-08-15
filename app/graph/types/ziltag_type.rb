# frozen_string_literal: true
ZiltagType = GraphQL::ObjectType.define do
  name 'Ziltag'
  description 'A ziltag entry'
  field :id, !types.ID, 'The unique ID for this ziltag', property: :slug
  field :map_id, !types.ID, 'The ziltag map ID which this ziltag belongs to' do
    resolve ->(obj, _args, _ctx) { obj.photo.slug }
  end
  field :content, !types.String, 'The content of this zitlag'
  field :usr, !UserType, 'The owner of this ziltag', property: :user
  field :comments, types[!CommentType], 'All comments of this ziltag'
  field :x, !types.Float
  field :y, !types.Float
  field :preview, !types.String, 'Truncated content' do
    resolve ->(obj, _args, _ctx) { obj.content.truncate(30) }
  end
  field :created_at, !types.String, 'example: 2016-03-12 18:14:28 +0800'
end
