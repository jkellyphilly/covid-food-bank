Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :community_members, path: "community-members", only: [:index, :new, :create, :show, :edit, :update]

  get '/community-members/login', to: 'sessions#new'
end
