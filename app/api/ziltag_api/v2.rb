# frozen_string_literal: true
class ZiltagAPI # :nodoc:
  class V2 < Grape::API # :nodoc:
    version 'v2', using: :path
    prefix :api
    format :json

    helpers do
      def warden
        env['warden']
      end
    end

    desc 'subscribe ziltag notification'
    params do
      requires :token, type: String, allow_blank: false
    end
    post :subscribe do
      begin
        user_id, ziltag_id = Unsubscribe.verify params[:token]
        user = User.find(user_id)
        ziltag = Ziltag.find(ziltag_id)
        subscribe = Subscribe.perform(user, ziltag)
        if subscribe.success?
          {}
        else
          { errors: [{ message: subscribe[:error] }] }
        end
      rescue
        { errors: [{ message: 'token not valid' }] }
      end
    end

    desc 'Sign user in'
    params do
      requires :sign_in, type: String, desc: 'email or username'
      requires :password, type: String
    end
    post :sign_in do
      authenticate_user = AuthenticateUser.perform(
        params[:sign_in], params[:password]
      )
      if authenticate_user.success?
        user = authenticate_user.user
        warden.set_user(user, scope: :user)
        {
          id: user.id,
          avatar: user.avatar.thumb.url,
          confirmed: user.confirmed?,
          email: user.email,
          name: user.username
        }
      else
        { errors: [{ message: authenticate_user.error }] }
      end
    end

    desc 'Sign user out'
    get :sign_out do
      warden.logout
      {}
    end

    desc 'Create Password Reset Request'
    params do
      requires :email, type: String, allow_blank: false
    end
    post :password do
      user = User.find_by(email: params[:email])
      if user
        send_reset_password = SendResetPassword.perform(user)
        if send_reset_password.success?
          {}
        else
          { errors: [{ message: send_reset_password.error }] }
        end
      else
        { errors: [{ message: 'user not found' }] }
      end
    end

    desc 'Reset Password'
    params do
      requires :reset_password_token, type: String, allow_blank: false
      requires :password, type: String, allow_blank: false
      requires :password_confirmation, type: String, allow_blank: false
    end
    put :reset_password do
      user = User.reset_password_by_token(
        reset_password_token: params[:reset_password_token],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )
      if user.errors.empty?
        warden.set_user(user, scope: :user)
        {
          id: user.id,
          avatar: user.avatar.thumb.url,
          confirmed: user.confirmed?,
          email: user.email,
          name: user.username
        }
      else
        { errors: user.errors.full_messages.map { |msg| { message: msg } } }
      end
    end

    desc 'Verify Accoutn'
    params do
      requires :confirmation_token, type: String, allow_blank: false
      requires :password, type: String, allow_blank: false
      requires :password_confirmation, type: String, allow_blank: false
    end
    post :verify do
      verify_user = VerifyUser.call(
        params[:confirmation_token],
        params[:password],
        params[:password_confirmation]
      )
      if verify_user.success?
        user = verify_user[:user]
        warden.set_user(verify_user[:user], scope: :user)
        {
          id: user.id,
          avatar: user.avatar.thumb.url,
          confirmed: user.confirmed?,
          email: user.email,
          name: user.username
        }
      else
        { errors: [message: verify_user[:error]] }
      end
    end
  end
end
