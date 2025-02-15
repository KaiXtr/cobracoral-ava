Rails.application.routes.draw do
  resources :usuarios
  resources :cursos
  resources :turmas
  resources :disciplinas do
    resources :unidade_disciplinas do
      resources :conteudos
    end
  end
  
  root "inicio#index"

  get "/instalar", to: "inicio#instalar"
  get "/aprender", to: "inicio#aprender"
  
  get '/entrar', to: 'sessions#login'
  post '/entrar', to: 'sessions#create'
  get '/sair', to: 'sessions#destroy'
end
