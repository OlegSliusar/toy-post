Rails.application.routes.draw do
  root   'microposts#index'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/about',      to: 'static_pages#about'
  resources :microposts
  resources :users
  resources :password_resets, only: [:new, :create, :edit, :update]
end
