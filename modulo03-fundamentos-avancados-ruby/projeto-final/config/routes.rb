Rails.application.routes.draw do
  get "player_characters" => "player_character#index"
  get "player_characters/:id" => "player_character#show"
  post "player_characters" => "player_character#create"
  delete "player_characters/:id" => "player_character#destroy"

  post "simulate_encounter" => "encounter#simulate_encounter"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
