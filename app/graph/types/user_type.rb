UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user entry'
  field :name, !types.String, 'The username of this user', property: :username
  field :isPartner, !types.Boolean, property: :content_provider?
  field :avatar, !types.String, 'The avatar URL of this user' do
    resolve ->(obj, args, ctx){ obj.avatar.thumb.url }
  end
  field :confirmed, !types.Boolean, 'This user is verified or not', property: :confirmed?
  field :email, !types.String, "User's email"
  field :ziltags, ->{ types[!ZiltagType] } do
    argument :page, types.Int, default_value: 1
    resolve ->(obj, args, _ctx){ obj.ziltags.page(args[:page]) }
  end
  field :comments, ->{ types[!CommentType] } do
    argument :page, types.Int, default_value: 1
    resolve ->(obj, args, _ctx){ obj.comments.page(args[:page]) }
  end
  field :website, ->{ WebsiteType } do
    resolve ->(obj, _args, _ctx){ obj.boxes.first }
  end
  field :websites, ->{ types[!WebsiteType] } do
    resolve ->(obj, _args, _ctx){ obj.boxes.includes(ziltags: :user, comments: :user) }
  end
end