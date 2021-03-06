# frozen_string_literal: true
Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/api/v2/graphql'
  end

  root 'pages#home'
  get 'doc', to: 'pages#home'
  get 'm/demo', to: 'pages#m_demo'
  get 'm/(*path)', to: 'pages#home'
  get '/preview/:id', to: 'pages#preview'
  get 'dashboard/redirect', to: 'dashboard#redirect'
  get 'dashboard/(*path)', to: 'dashboard#index'

  mount ZiltagAPI => '/'
  get 'api/v2/graphql', to: 'api/v2/graphql#execute'
  post 'api/v2/graphql', to: 'api/v2/graphql#execute'

  get :unsubscribe, controller: :subscribtion

  devise_for :users, skip: :all

  match '/api/:version/*path' => 'api#options', via: 'options'
  namespace :api, format: false, defaults: { format: 'json' } do
    namespace :v1 do
      post 'track' => 'tracks#record'
      get 'ziltag_maps/:id' => 'photos#show'
      resources :ziltags, only: %i(index show create update destroy)
      resources :comments, only: %i(show create update destroy)
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
