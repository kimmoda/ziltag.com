Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'

    controller :single_page do
      get :term_of_service, :privacy_policy, :install
    end

    devise_for :users, controllers: {confirmations: 'confirmations'}
    devise_scope :user do
      patch 'confirm' => 'confirmations#confirm'
    end

    get 'ziltags/:slug/(:ziltag_slug)' => 'photos#show', as: :photo, constraints: {slug: /\w{6}/, ziltag_slug: /\w{6}/}
    resources :photos, only: :create
    resources :ziltags, only: %i[create update destroy] do
      get :preview_image, on: :member
    end
    resources :comments, only: %i[create update destroy]
    resources :subscribers, only: :create

    namespace :api, format: false, defaults: {format: 'json'} do
      namespace :v1 do
        resources :ziltags, only: :index
      end
    end
  end
end
