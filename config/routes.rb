Rails.application.routes.draw do
  resources :comunicados
  resources :usuarios
  resources :cursos
  resources :turmas
  resources :disciplinas
  resources :unidade_disciplinas
  resources :conteudos
  resources :leitura_conteudos
  
  root 'comunicados#index'
  
  get '/entrar', to: 'sessions#login'
  post '/entrar', to: 'sessions#create'
  get '/primeiro-acesso', to: 'sessions#primeiro_acesso'
  post '/primeiro-acesso', to: 'sessions#edit'
  get '/problemas-acesso', to: 'sessions#problemas-acesso'
  post '/problemas-acesso', to: 'sessions#recover_password'
  get '/recuperar', to: 'sessions#recuperar'
  post '/recuperar', to: 'sessions#validate_recovery'

  get '/usuarios/:id/caixa', to: 'usuarios#caixa'
  get '/usuarios/:id/lattes', to: 'usuarios#lattes'
  get '/painel', to: 'painel#index'
  get '/perfil', to: 'usuarios#perfil'
  get '/sair', to: 'sessions#destroy'

  get '/cursos', to: 'cursos#index'
  get '/ide', to: 'ide#index'
  get '/tarefas', to: 'leitura_conteudos#index'
  get '/mensagens', to: 'cursos#index'

  get '/usuarios/:usuario_id/editar', to: 'usuarios#edit'
  get '/usuarios/:usuario_id/:turma_id/matricular', to: 'usuarios#matricular'
  get '/usuarios/:usuario_id/:turma_id/desmatricular', to: 'usuarios#desmatricular'
  
  get '/ext/entrar', to: 'usuarios_ext#get_auth_token'
  get '/ext/usuarios', to: 'usuarios_ext#get_usuarios'
  post '/ext/usuarios/new', to: 'usuarios_ext#create_usuario'

  get '/comunicados/:id/reagir/:emoji', to: 'comunicados#reagir'
  get '/comunicados/:id/editar', to: 'comunicados#edit'
  get '/comunicados/:id/deletar', to: 'comunicados#delete'
  get '/comunicados/:id/destroy', to: 'comunicados#destroy'

  get '/cursos/:id/editar', to: 'cursos#edit'
  get '/cursos/:id/deletar', to: 'cursos#delete'
  get '/cursos/:id/destroy', to: 'cursos#destroy'

  get '/turmas/:id/matricular', to: 'turmas#matricular'
  get '/turmas/:id/editar', to: 'turmas#edit'
  get '/turmas/:id/deletar', to: 'turmas#delete'
  get '/turmas/:id/destroy', to: 'turmas#destroy'

  get '/disciplinas/:id/editar', to: 'disciplinas#edit'
  get '/disciplinas/:id/deletar', to: 'disciplinas#delete'
  get '/disciplinas/:id/destroy', to: 'disciplinas#destroy'

  get '/conteudos/:id/editar', to: 'conteudos#edit'
  get '/conteudos/:id/salvar', to: 'conteudos#salvar'
  get '/conteudos/:id/deletar', to: 'conteudos#delete'
  get '/conteudos/:id/destroy', to: 'conteudos#destroy'

  get '/sobre', to: 'sobre#index'
  get '/instalar', to: 'sobre#instalar'
  get '/aprender', to: 'sobre#aprender'
end
