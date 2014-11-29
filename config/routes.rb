Rails.application.routes.draw do

  
  devise_for :users
  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  put "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'
  
  resources :users
  resources :users, :path => :captains, :as => :captains
  resources :users, :path => :captains, :as => :captains do 
    resources :teams
  end
  resources :teams do
    resources :users, :path => :teammates, :as => :teammates
  end
  
  #get "/users" => "users#update", as: 'update'
  
  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'
end
