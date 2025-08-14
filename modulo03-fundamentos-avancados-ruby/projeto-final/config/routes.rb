Rails.application.routes.draw do
  get "player_characters" => "player_characters#index"
  get "player_characters/:id" => "player_characters#show"
  post "player_characters" => "player_characters#create"
  delete "player_characters/:id" => "player_characters#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
