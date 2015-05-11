Rails.application.routes.draw do
  root 'pages#home'
  resources :ziltaggings, only: :index

  devise_for :users

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos
    resources :ziltaggings, only: :index
  end
end
