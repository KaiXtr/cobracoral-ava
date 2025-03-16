class SessionsController < ApplicationController
	layout 'login'

	def primeiroAcesso
		@usuario_autenticado = usuario_autenticado
		@pronomes = PronomesUsuario.all
		@cargo = UsuarioCargo.find(@usuario_autenticado.usuario_cargo_id).enumCargoMasculino
		render "primeiro-acesso"
	end

	def create
		usuario = Usuario.find_by(email: params[:session][:email])

		if usuario then
			if usuario.authenticate(params[:session][:senha]) then
				logar(usuario)
			else
				respond_to do |format|
					logtxt = "Senha incorreta"
					Rails.logger.error logtxt
					format.html { redirect_to "/entrar", notice: logtxt }
					format.json { render json: { error: logtxt }, status: :unauthorized }
				end
			end
		else
			respond_to do |format|
				logtxt = "Não há usuário cadastrado com o email informado"
				Rails.logger.error logtxt
				format.html { redirect_to "/entrar", notice: logtxt }
				format.json { render json: { error: logtxt }, status: :unauthorized }
			end
		end
	end
	
	def destroy
		logout if logado?
		Rails.logger.info "Destruindo sessão de usuário."
		redirect_to root_path
	end
end
