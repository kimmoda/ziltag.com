Rails.application.routes.draw do
  root 'pages#home'

  devise_for :users

  namespace :admin do
    root action: :home
    resources :users, :comments, :posts, :photos
  end
end
