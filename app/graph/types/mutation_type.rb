MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'The mutation root'

  field :createUser, UserType do
    argument :username, !types.String
    argument :email, !types.String
    resolve -> (_obj, args, ctx) do
      user_sign_up = UserSignUp.call(args[:username], args[:email])
      user_sign_up.success? ? user_sign_up[:user] : raise(user_sign_up[:error])
    end
  end

  field :createZiltag, ZiltagType do
    argument :x, !types.Float
    argument :y, !types.Float
    argument :content, !types.String
    argument :map_id, !types.ID
    resolve -> (_obj, args, ctx) do
      create_ziltag = CreateZiltag.call(ctx[:current_user], args[:map_id], args[:x], args[:y], args[:content])
      create_ziltag.success? ? create_ziltag[:ziltag] : raise(create_ziltag[:error])
    end
  end

  field :updateZiltag, ZiltagType do
    argument :id, !types.ID, 'Ziltag ID'
    argument :content, !types.String
    resolve -> (_obj, args, _ctx) do
      ziltag = Ziltag.find_by!(slug: args[:id])
      ziltag.update(content: args[:content]) ? ziltag : raise(ziltag.errors.full_messages.first)
    end
  end
end
