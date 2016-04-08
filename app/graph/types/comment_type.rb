CommentType = GraphQL::ObjectType.define do
  name 'Comment'
  description 'A comment entry'
  field :id, !types.ID, 'The ID of this comment'
  field :content, !types.String, 'The content of this comment'
  field :created_at, !types.String, 'Time of creation'
  field :usr, !UserType, 'The author of this comment', property: :user
end