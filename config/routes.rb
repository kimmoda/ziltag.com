Rails.application.routes.draw do
  scope '(:locale)', locale: /zh-TW|ja/ do
    root 'pages#landing'
    controller :pages do
      get :privacy_policy, :term_of_service, :home, :landing
    end
    devise_for :users, controllers: {registrations: :registrations}
    resource :photo, only: :show
    resources :photos, :stickers, only: :create
    resources :subscribers, only: :create
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings, :tags
    get 'select2/:plural' => 'select2#query'
  end
end
