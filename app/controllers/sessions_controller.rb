class SessionsController < ApplicationController
	def criar
		usuario = Usuario.find_by(email: params[:session][:email])
		if usuario
			logar(usuario)
		else
			render 'nova'
		end
	end
	
	def destruir
		logout if logado?
		redirect_to root_path
	end
end
