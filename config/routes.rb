Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users

  resources :ziltaggings, only: %i[index show]

  controller :following do
    post :follow
    delete :unfollow
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos
    resources :ziltaggings, only: :index
  end
end
