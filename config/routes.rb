Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  resources :ziltaggings, only: :show
  resources :photos, only: :index

  controller :following do
    post :follow
    delete :unfollow
  end

  controller :collecting do
    post :collect
    delete :uncollect
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings
    get 'select2/:plural' => 'select2#query'
  end
end
