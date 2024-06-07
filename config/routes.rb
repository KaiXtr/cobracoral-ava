Rails.application.routes.draw do
  root "inicio#index"

  get "/inicio", to: "inicio#index"
  get "/aprender", to: "inicio#aprender"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
