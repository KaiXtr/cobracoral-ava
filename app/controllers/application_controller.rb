require "action_text"

class ApplicationController < ActionController::Base
	include Pundit::Authorization
	helper ActionText::Engine.helpers

	def usuario_autenticado
		if session[:usuario_id]
			if Usuario.where(id: session[:usuario_id]).length > 0 then
				@usuario_autenticado = Usuario.find(session[:usuario_id])
				@preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: @usuario_autenticado.id)
			else
				Rails.logger.info "Usuário previamente autenticado foi deletado. Encerrando sessão."
				logout
			end
		end
	end

    def redirecionar_nao_logado
        @usuario_autenticado = usuario_autenticado
        redirect_to '/entrar' unless @usuario_autenticado
    end

	def current_user
		usuario_autenticado
	end

	def index
		@usuario_autenticado = usuario_autenticado
	end

	def show
		@usuario_autenticado = usuario_autenticado
	end

	def logar(usuario, sessionData)
		@usuario_autenticado = usuario
		session[:usuario_id] = usuario.id
		session[:login_time] = Time.now

		if sessionData != nil then
			session[:login_device] = sessionData[:login_device]
			session[:login_so] = sessionData[:login_so]
			session[:login_browser] = sessionData[:login_browser]

			SessionMailer.with(
				usuario: usuario,
				login_device: session[:login_device],
				login_so: session[:login_so],
				login_browser: session[:login_browser],
				login_time: Time.now).acesso_email.deliver_later
		end
		
		Rails.logger.info "Criada sessão para o(a) usuário(a) com email " + usuario.email + "."
		
		redirect_to root_path
	end

	def logar_EXT(usuario)
		# USUÁRIO ADMINISTRADOR INFORMA API_KEY E SE LOGA COMO ADMINISTRADOR DO COBRACORAL

		session[:usuario_id] = usuario.id
		@usuario_autenticado = usuario

		Rails.logger.info "Criada sessão para o(a) usuário(a) com email " + usuario.email + "."
		
		respond_to do |format|
			format.json { render json: { token: session }, status: :ok }
		end
	end

	def logado?
		!usuario_autenticado.nil?
	end

	def logout
		session.delete(:usuario_id)
		@usuario_autenticado = nil
	end
end
