Rails.application.routes.draw do


  devise_for :users
  
  get "/users/:id" => "users#admin_show", as: 'admin_show'
  get "/users/:id" => "users#admin_form", as: 'admin_form'
  put "/users/:id" => "users#admin_info_create", as: 'admin_info_create'


  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  put "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'

  resources :users

  resources :users, :path => :captains, :as => :captains, :controller => "captains" do
    resources :teams, :only => [:new, :create, :edit, :update, :destroy], controller: 'captains/teams'
  end

  resources :teams, :only => [:index, :show] do
    resources :users, :path => :teammates, :as => :teammates, :controller => "teammates"
  end

  resources :users, :path => :teammates, :as => :teammates, :controller => "teammates", :only => [:new, :create, :show, :add_teammate_to_team]
  #get "/users" => "users#update", as: 'update'

  get "/messages/multi_team_chat" => "messages#index_multi_team_chat", as: 'multi_team_chat'
  put "/messages/create_multi_team_chat" => "messages#create_multi_team_chat", as: 'create_multi_team_chat'

  resources :messages

  get '/add_teammate_to_team/:id' => "teammates#add_teammate_to_team", :as => :add_teammate_to_team
 # get '/school_sort' => "students#school_sort", :as => :sort_school
  



  get 'welcome/index'
  get 'welcome/about'

  root to: 'welcome#index'
end
