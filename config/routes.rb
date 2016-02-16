Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'

    controller :pages do
      get :username, :platform, :install
      patch :username, action: 'update_username'
      post :platform, action: 'update_platform'
      post :register
    end

    devise_for :users, controllers: {confirmations: 'confirmations', registrations: 'registrations'}
    devise_scope :user do
      patch 'confirm' => 'confirmations#confirm'
    end
  end

  match '/api/:version/*path' => 'api#options', via: 'options'
  namespace :api, format: false, defaults: {format: 'json'} do
    namespace :v1 do
      post 'track' => 'tracks#record'
      get 'ziltag_maps/:id' => 'photos#show'
      resources :ziltags, only: %i[index show create update destroy]
      resources :comments, only: %i[show create update destroy]
      devise_scope :user do
        get 'me' => 'users#me'
        controller 'users/sessions' do
          post 'sign_in', action: 'create'
          get 'sign_out', action: 'destroy'
        end
        controller 'users/registrations' do
          post 'users', action: 'create'
          put 'users', action: 'update'
        end
        controller 'users/confirmations' do
          post 'resend_confirmation', action: 'resend'
        end
      end
    end
  end

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end
    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
end
