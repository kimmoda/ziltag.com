class ZiltagAPI
  class V2 < Grape::API
    version 'v2', using: :path
    prefix :api
    format :json

    helpers do
      def warden
        env['warden']
      end
    end

    desc 'Sign user in'
    params do
      requires :sign_in, type: String, desc: 'email or username'
      requires :password, type: String
    end
    post :sign_in do
      authenticate_user = AuthenticateUser.call(params[:sign_in], params[:password])
      if authenticate_user.success?
        user = authenticate_user[:user]
        warden.set_user(user, scope: :user)
        {
          avatar: user.avatar.thumb.url,
          confirmed: user.confirmed?,
          email: user.email,
          name: user.username
        }
      else
        {errors: [message: authenticate_user[:error]]}
      end
    end

    desc 'Sign user out'
    get :sign_out do
      warden.logout
      {}
    end

    desc 'Verify Accoutn'
    params do
      requires :confirmation_token, type: String, allow_blank: false
      requires :password, type: String, allow_blank: false
      requires :password_confirmation, type: String, allow_blank: false
    end
    post :verify do
      verify_user = VerifyUser.call params[:confirmation_token], params[:password], params[:password_confirmation]
      if verify_user.success?
        user = verify_user[:user]
        warden.set_user(verify_user[:user], scope: :user)
        {
          avatar: user.avatar.thumb.url,
          confirmed: user.confirmed?,
          email: user.email,
          name: user.username
        }
      else
        {errors: [message: verify_user[:error]]}
      end
    end

  end
end