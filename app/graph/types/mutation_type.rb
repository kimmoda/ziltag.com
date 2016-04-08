MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  description 'The mutation root'

  field :createUser, UserType do
    argument :username, !types.String
    argument :email, !types.String
    resolve -> (_obj, args, ctx) do
      user_sign_up = UserSignUp.call(args[:username], args[:email])
      if user_sign_up.success?
        user_sign_up[:user]
      else
        raise user_sign_up[:error]
      end
    end
  end
end
