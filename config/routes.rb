Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'

    controller :single_page do
      get :term_of_service, :privacy_policy
    end

    devise_for :users, controllers: {registrations: :registrations}

    get ':slug/(:ziltag_slug)' => 'photos#show', as: :photo, constraints: {slug: /\w{6}/, ziltag_slug: /\w{6}/}
    resources :photos, only: :create
    resources :ziltags, :comments, only: %i[create update destroy]
    resources :subscribers, only: :create

    namespace :api, format: false, defaults: {format: 'json'} do
      namespace :v1 do
        resources :ziltags, only: :index
      end
    end
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings, :tags
    get 'select2/:plural' => 'select2#query'
  end
end
