Rails.application.routes.draw do

  get 'static_pages/about'

  resources :microposts
  resources :users
  root 'microposts#new'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
