Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  get '/community-members/login', to: 'community_members#login'
  post '/community-members/login', to: 'sessions#create'
  get '/volunteers/login', to: 'volunteers#login'
  post '/volunteers/login', to: 'sessions#create'

  resources :community_members, path: 'community-members' do
    resources :delivery_requests, path: 'delivery-requests', only: [:index]
  end

  resources :volunteers
  resources :delivery_requests, path: "delivery-requests"

  get '/logout', to: 'sessions#destroy'
end
