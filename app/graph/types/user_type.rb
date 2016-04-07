UserType = GraphQL::ObjectType.define do
  name 'User'
  description 'A user entry'
  field :name, !types.String, 'The username of this user', property: :username
  field :avatar, !types.String, 'The avatar URL of this user' do
    resolve ->(obj, args, ctx){ obj.avatar.thumb.url }
  end
  field :confirmed, !types.Boolean, 'This user is verified or not', property: :confirmed?
  field :email, !types.String, "User's email"
end