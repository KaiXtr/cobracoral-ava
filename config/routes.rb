Rails.application.routes.draw do
  resources :turmas
  resources :usuarios
  
  root "inicio#index"

  get "/inicio", to: "inicio#index"
  get "/instalar", to: "inicio#instalar"
  get "/aprender", to: "inicio#aprender"
  
  get '/entrar', to: 'sessions#nova'
  post '/entrar', to: 'sessions#criar'
  delete '/sair', to: 'sessions#destroy'

  get '/turmas', to: 'turmas#index'
end
