Rails.application.routes.draw do
  root 'pages#home'
  namespace :admin do
    root action: :home
  end
end
