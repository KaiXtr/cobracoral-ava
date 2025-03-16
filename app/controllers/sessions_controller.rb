class SessionsController < ApplicationController
	layout 'login'

	def get_auth_token
		usuario = Usuario.find_by(email: params[:email])
		auth = usuario.authenticate(params[:senha])

		if auth then
			logar_EXT(usuario)
		else
			respond_to do |format|
				logtxt = "Senha incorreta"
				Rails.logger.error "[EXT] Erro ao obter token de autenticação."
				format.json { render json: { error: usuario.errors }, status: :unauthorized }
			end
		end
	end

	def create
		usuario = Usuario.find_by(email: params[:session][:email])

		if usuario then
			if usuario.authenticate(params[:session][:senha]) then
				if (usuario.acessos_count == 0) then
					Rails.logger.info "Primeiro acesso do usuário."
					session[:primeiro_acesso] = usuario.id
					redirect_to "/primeiro-acesso"
				else
					logar(usuario)
				end
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

	def primeiroAcesso
		@usuario_autenticado = Usuario.find(session[:primeiro_acesso])

		if @usuario_autenticado.acessos_count > 0 then
			redirect_to root_path
		end

		@pronomes = PronomesUsuario.all
		@cargo = UsuarioCargo.find(@usuario_autenticado.usuario_cargo_id).enumCargoMasculino
		render "primeiro-acesso"
	end

	def edit
		usuario_autenticado = params[:usuario_autenticado]

		if (usuario_autenticado[:new_password] == usuario_autenticado[:repeat_password])
			usuario = Usuario.find(session[:primeiro_acesso])
			senha_nova = BCrypt::Password.create(usuario_autenticado[:new_password])
			usuario.password = usuario_autenticado[:new_password]
			usuario.password_digest = senha_nova

			if usuario.save then
				Rails.logger.info "Senha do usuário alterada."
				usuario.acessos_count += 1
				usuario.save

				logar(usuario)
			else
				respond_to do |format|
					if usuario.errors["password"] then
						logtxt = "Senha não cumpre os requisitos"
					else
						logtxt = usuario.errors
					end
					Rails.logger.error logtxt
					format.html { redirect_to "/primeiro-acesso", notice: logtxt }
					format.json { render json: { error: usuario.errors }, status: :unauthorized }
				end
			end
		else
			respond_to do |format|
				logtxt = "As senhas não conferem."
				Rails.logger.error logtxt
				format.html { redirect_to "/primeiro-acesso", notice: logtxt }
				format.json { render json: { error: usuario.errors }, status: :unauthorized }
			end
		end
	end
	
	def destroy
		logout if logado?
		Rails.logger.info "Destruindo sessão de usuário."
		redirect_to root_path
	end
end
