Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  namespace :admin do
    resources :users
  end
  root 'pages#home'

  devise_for :users

  namespace :admin do
    root action: :home
    resources :users
  end
end
