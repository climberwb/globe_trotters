Rails.application.routes.draw do

  
  devise_for :users
  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  put "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'
  
  resources :users
  
  resources :users, :path => :captains, :as => :captains do 
    resources :teams, :only => [:new, :create, :edit, :update, :destroy], controller: 'captains/teams'
  end

  resources :teams, :only => [:index, :show] do
    resources :users, :path => :teammates, :as => :teammates, :controller => "teammates"
  end
  
  resources :users, :path => :teammates, :as => :teammates, :controller => "teammates", :only => [:new, :create, :show]
  #get "/users" => "users#update", as: 'update'
  
  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'
end
