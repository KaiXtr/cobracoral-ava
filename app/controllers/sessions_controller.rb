class SessionsController < ApplicationController
	def criar
		usario = Usuario.find_by(nome_completo: params[:session][:nome_completo])
		if usuario
			logar(usuario)
		else
			render 'new'
		end
	end
	
	def destruir
		logout if logado?
		redirect_to root_path
	end
end
