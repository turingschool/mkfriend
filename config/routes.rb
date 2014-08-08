Rails.application.routes.draw do
  root to: "games#new"

  resources :games, only: [:new, :create, :show, :update, :edit]
end
