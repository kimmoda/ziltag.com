Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  resources :users, only: :show
  resources :ziltaggings, only: %i[show update destroy]
  resources :photos, only: %i[index show create]
  resources :posts, only: %i[index show create update destroy]

  post 'redactor/images'

  controller :following do
    post :follow
    delete :unfollow
  end

  controller :collecting do
    post :collect
    delete :uncollect
  end

  namespace :embedded do
    get :photos, format: true, constraints: {format: :json}
    get 'ziltagging/:id', action: :ziltagging, format: false, as: :ziltagging
    get :preview if Rails.env.development?
  end

  namespace :admin, path: (Rails.env.production? ? Settings.admin.path : :admin) do
    root action: :home
    resources :users, :comments, :posts, :photos, :ziltaggings
    get 'select2/:plural' => 'select2#query'
  end
end
