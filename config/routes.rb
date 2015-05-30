Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users
  resources :ziltaggings, only: :show
  resources :photos, only: %i[index show]

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
