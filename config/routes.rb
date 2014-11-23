Rails.application.routes.draw do

 # devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :users
  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  put "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'

  resources :users

  #get "/users" => "users#update", as: 'update'
  
  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'
end
