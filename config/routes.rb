Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#welcome'

  get '/community-members/login', to: 'community_members#login'
  post '/community-members/login', to: 'sessions#create'
  get '/volunteers/login', to: 'volunteers#login'
  post '/volunteers/login', to: 'sessions#create'
  get '/delivery-requests/:id/volunteer', to: 'delivery_requests#volunteer'
  get '/auth/github/callback', to: 'sessions#create'
  get '/community-members/:id/todays-confirmed-requests', to: 'community_members#todays_confirmed_requests'
  get '/community-members/:id/todays-completed-requests', to: 'community_members#todays_completed_requests'

  resources :community_members, path: 'community-members' do
    resources :delivery_requests, path: 'delivery-requests', only: [:index, :show, :new]
  end

  resources :volunteers do
    resources :delivery_routes, path: 'delivery-routes', only: [:index, :show, :edit, :update, :destroy]
  end

  resources :delivery_requests, path: "delivery-requests"

  resources :comments, only: [:index, :create]

  get '/logout', to: 'sessions#destroy'
end
