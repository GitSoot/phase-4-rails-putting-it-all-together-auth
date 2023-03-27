Rails.application.routes.draw do
    post "/signup", to: "users#create"
    post "/login", to: "sessions#create"
    resources :recipes, only: [:index, :create]
    delete "/logout", to: "sessions#destroy"
    get "/me", to: "users#show"
end
