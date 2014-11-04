Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
  get 'welcome/index'

  get 'welcome/about'
  get  'users/binary_selection'
  root to: 'welcome#index'
 
end
