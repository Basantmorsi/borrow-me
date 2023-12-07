Rails.application.routes.draw do
  get 'tools/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tools do
    resources :tool_requests
  end

  resources :tool_requests, only: [:index, :new, :create]
  resources :dashboard
  resources :tool_requests do
    patch 'approve', on: :member
  end
  get "dashboards/profile", to: "dashboard#profile", as: "/profile"
  # Defines the root path route ("/")
  # root "posts#index"
end
