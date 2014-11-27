Rails.application.routes.draw do

  

  # get 'teammates/index'

  # get 'teammates/create'

  # get 'teammates/new'

  # get 'teammates/destroy'

  # get 'teammates/show'

  # get 'captains/index'

  # get 'captains/create'

  # get 'captains/new'

  # get 'captains/destroy'

  # get 'captains/show'

  # get 'teamcaptains/show'

 # devise_for :users, :controllers => {:registrations => "registrations"}
  devise_for :users
  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  put "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'
  
  resources :users
  resources :users, :path => :captains
  resources :users, :path => :captains do 
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
