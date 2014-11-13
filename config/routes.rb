Rails.application.routes.draw do
  
devise_for :users#, :controllers => {:registrations => "registrations"}
     get "/users" => "users#binary_selection", as: 'binary_selection'
  get 'welcome/index'
  get 'welcome/about'
    
  root to: 'welcome#index'  
end
