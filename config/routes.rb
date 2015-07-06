Rails.application.routes.draw do
  namespace :admin do
    resources :tags
  end

  root 'pages#home'
  controller :pages do
    get :privacy_policy, :term_of_service
  end

  devise_for :users
  resources :users, only: :show do
    get :collecting, :following, :leading, on: :member
  end
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
