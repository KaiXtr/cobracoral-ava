Rails.application.routes.draw do
  resources :usuarios
  resources :cursos
  resources :turmas
  resources :disciplinas
  resources :unidade_disciplinas
  resources :conteudos
  resources :leitura_conteudos
  
  root 'cursos#index'
  
  get '/entrar', to: 'sessions#login'
  post '/entrar', to: 'sessions#create'
  get '/recuperacao', to: 'sessions#recuperacao'
  get '/usuarios/:id/caixa', to: 'usuarios#caixa'
  get '/perfil', to: 'usuarios#perfil'
  get '/sair', to: 'sessions#destroy'

  get '/comunicados', to: 'cursos#index'
  get '/cursos', to: 'cursos#index'
  get '/ide', to: 'ide#index'
  get '/tarefas', to: 'leitura_conteudos#index'
  get '/mensagens', to: 'cursos#index'

  get '/usuarios/:usuario_id/:turma_id/matricular', to: 'usuarios#matricular'
  get '/usuarios/:usuario_id/:turma_id/desmatricular', to: 'usuarios#desmatricular'

  get '/turmas/:id/matricular', to: 'turmas#matricular'
  get '/turmas/:id/deletar', to: 'turmas#delete'

  get '/conteudos/:id/salvar', to: 'conteudos#salvar'

  get '/sobre', to: 'sobre#index'
  get '/instalar', to: 'sobre#instalar'
  get '/aprender', to: 'sobre#aprender'
end
