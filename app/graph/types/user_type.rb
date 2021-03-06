# frozen_string_literal: true
UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user entry'
  field :id, !types.ID
  field :name, !types.String, 'The username of this user', property: :username
  field :isPartner, !types.Boolean, property: :partner?
  field :ziltagNotification, !types.Boolean, property: :ziltag_notification?
  field :commentNotification, !types.Boolean, property: :comment_notification?
  field :avatar, !types.String, 'The avatar URL of this user' do
    resolve ->(obj, _args, _ctx) { obj.avatar.thumb.url }
  end
  field :confirmed, !types.Boolean, 'This user is verified or not', property: :confirmed?
  field :email, !types.String, "User's email"
  field :ziltags, -> { types[!ZiltagType] } do
    argument :page, types.Int, default_value: 1
    resolve ->(obj, args, _ctx) { obj.ziltags.page(args[:page]) }
  end
  field :comments, -> { types[!CommentType] } do
    argument :page, types.Int, default_value: 1
    resolve ->(obj, args, _ctx) { obj.comments.page(args[:page]) }
  end
  field :website, -> { WebsiteType } do
    resolve ->(obj, _args, _ctx) { obj.websites.first }
  end
  field :websites, -> { types[!WebsiteType] } do
    resolve ->(obj, _args, _ctx) { obj.websites.includes(ziltags: :user, comments: :user) }
  end
end
