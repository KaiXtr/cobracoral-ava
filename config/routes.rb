Rails.application.routes.draw do
  resources :turmas
  resources :usuarios
  
  get 'turmas/index'
  root "inicio#index"

  get "/inicio", to: "inicio#index"
  get "/instalar", to: "inicio#instalar"
  get "/aprender", to: "inicio#aprender"
  
  get '/entrar', to: 'sessions#nova'
  post '/entrar', to: 'sessions#criar'
  delete '/sair', to: 'sessions#destroy'
end
