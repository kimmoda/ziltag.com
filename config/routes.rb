Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'

    controller :pages do
      get :username, :platform, :install
      patch :username, action: 'update_username'
      post :platform, action: 'update_platform'
    end

    controller :single_page do
      get :term_of_service, :privacy_policy
      patch 'me', action: 'update_current_user'
    end

    devise_for :users, controllers: {confirmations: 'confirmations', registrations: 'registrations'}
    devise_scope :user do
      patch 'confirm' => 'confirmations#confirm'
    end

    get 'ziltags/:slug/(:ziltag_slug)' => 'photos#show', as: :photo, constraints: {slug: /\w{6}/, ziltag_slug: /\w{6}/}
    resources :comments, :ziltags, only: %i[create update destroy]

    namespace :api, format: false, defaults: {format: 'json'} do
      namespace :v1 do
        resources :ziltags, only: %i[index show create update destroy]
        resources :comments, only: %i[show create update destroy]
        devise_scope :user do
          controller 'users/sessions' do
            post 'sign_in', action: 'create'
            get 'sign_out', action: 'destroy'
          end
          controller 'users/registrations' do
            post 'users', action: 'create'
            put 'users', action: 'update'
          end
        end
      end
    end
  end
end
