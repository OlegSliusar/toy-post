Rails.application.routes.draw do
  get 'static_pages/about'

  resources :microposts
  resources :users
  root 'microposts#new'
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
