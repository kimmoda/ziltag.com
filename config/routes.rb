Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#home'
    controller :pages do
      get :landing
    end
    devise_for :users, controllers: {registrations: :registrations}

    resource :photo, only: :show
    get ':slug' => 'photos#permalink', as: :permalink
    resources :photos, only: :create
    resources :stickers, :comments, only: %i[create update destroy]
    resources :subscribers, only: :create
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings, :tags
    get 'select2/:plural' => 'select2#query'
  end
end
