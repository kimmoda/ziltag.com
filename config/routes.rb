Rails.application.routes.draw do
  namespace :admin do
    resources :ziltaggings
  end
  root 'pages#home'

  devise_for :users
  resources :ziltaggings, only: :show
  resources :photos, only: :index

  controller :following do
    post :follow
    delete :unfollow
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings
  end
end
