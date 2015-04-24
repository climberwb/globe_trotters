Rails.application.routes.draw do


  devise_for :users

  get "/users/:id" => "users#binary_selection", as: 'binary_selection'
  post "/users/:id" => "users#binary_selection_update", as: 'binary_selection_update'

  get "/users/:id/admin_form" => "users#admin_form", as: 'admin_form'
  get "/users/:id/admin_show" => "users#admin_show", as: 'admin_show'
  put "/users/:id/admin_info_create" => "users#admin_info_create", as: 'admin_info_create'

  get  '/users/:id/individual_form' => "users#individual_form", as: "individual_form"
  post '/users/:id/individual_form_post' => "users#individual_form_post", as: "individual_form_post"
  get  '/users/:id/individual_show' => "users#individual_show", as: "individual_show"

  get  "/to_geo_json" => "users#to_geo_json"#, as:"individual_to_geo_json"
  post "/location_search" => "users#location_search"#, as: "individual_location_search"

  resources :users


  resources :users, :path => :captains, :as => :captains, :controller => "captains" do
    resources :teams, :only => [:new, :create, :edit, :update, :destroy], controller: 'captains/teams'
  end

   get "/teams/to_geo_json" => "teams#to_geo_json"

  resources :teams, :only => [:index, :show] do
    resources :users, :path => :teammates, :as => :teammates, :controller => "teammates"
  end

  #post 'captains/:id/teams' => "teams#verify_address"#, as: 'verify_address'
  # post 'captains/:id/teams' => "teams#verify_address", as: 'verify_address'
  post "/teams/location_search" => "teams#location_search"
  resources :users, :path => :teammates, :as => :teammates, :controller => "teammates", :only => [:new, :create, :show, :add_teammate_to_team]
  #get "/users" => "users#update", as: 'update'

  get "/messages/multi_team_chat" => "messages#index_multi_team_chat", as: 'multi_team_chat'
  put "/messages/create_multi_team_chat" => "messages#create_multi_team_chat", as: 'create_multi_team_chat'
  resources :conversations
  resources :messages

  get '/add_teammate_to_team/:id' => "teammates#add_teammate_to_team", :as => :add_teammate_to_team
 # get '/school_sort' => "students#school_sort", :as => :sort_school

  resources :team_relationships
  post "/team_relationships/create" => "team_relationships#create"
  post "/team_relationships/team_accept" => "team_relationships#team_accept"
  post "/team_relationships/team_decline" => "team_relationships#team_decline"

  resources :individual_relationships
  post "/individual_relationships/create" => "individual_relationships#create"
  post "/individual_relationships/accept" => "individual_relationships#accept"
  post "/individual_relationships/decline" => "individual_relationships#decline"
  post "/individual_relationships/delete" => "individual_relationships#delete"

  resources :vidconferences

  get 'welcome/index'
  get 'welcome/about'

  post "/team_relationships/team_accept" => "team_relationships#team_accept"
  post "/team_relationships/team_decline" => "team_relationships#team_decline"
  resources :users do
    resources :answers
  end

  root to: 'welcome#index'


end
