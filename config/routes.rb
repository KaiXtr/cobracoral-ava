Rails.application.routes.draw do
  resources :turmas
  resources :usuarios
  
  root "inicio#index"

  get "/instalar", to: "inicio#instalar"
  get "/aprender", to: "inicio#aprender"
  
  get '/entrar', to: 'sessions#login'
  post '/entrar', to: 'sessions#create'
  get '/sair', to: 'sessions#destroy'
end
