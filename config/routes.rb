Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'

    controller :pages do
      get :username, :install
      patch :username, action: 'update_username'
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
        resources :ziltags, only: :index
        devise_scope :user do
          post 'users/sign_in' => 'users/sessions#create'
          delete 'users/sign_out' => 'users/sessions#destroy'
        end
      end
    end
  end
end
