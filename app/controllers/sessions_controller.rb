class SessionsController < ApplicationController
	def index
		@login_fail = ''
	end

	def create
		usuario = Usuario.find_by(
			email: params[:session][:email])
		if usuario
			logar(usuario)
		else
			@login_fail = "Email ou senha incorretos"
		end
	end
	
	def destroy
		logout if logado?
		redirect_to root_path
	end
end
