Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users

  namespace :admin, path: (Rails.env.development? ? :admin : Settings.admin.path) do
    root action: :home
    resources :users, :comments, :posts, :photos
  end
end
