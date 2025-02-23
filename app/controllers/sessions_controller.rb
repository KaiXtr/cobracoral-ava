class SessionsController < ApplicationController
	layout 'login'
	
	def index
	end

	def create
		usuario = Usuario.find_by(
			email: params[:session][:email])
		if usuario
			Rails.logger.info "Criada sessão para o usuário com email " + params[:session][:email]
			logar(usuario)
		else
			Rails.logger.error "Falha ao realizar autenticação do usuário"
			@login_fail = "Email ou senha incorretos"
		end
	end
	
	def destroy
		logout if logado?
		Rails.logger.info "Destruindo sessão de usuário."
		redirect_to root_path
	end
end
