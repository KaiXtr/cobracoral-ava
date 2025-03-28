require "action_text"

class ApplicationController < ActionController::Base
	include Pundit::Authorization
	helper ActionText::Engine.helpers

	def usuario_autenticado
		if session[:usuario_id]
			@usuario_autenticado = Usuario.find(session[:usuario_id])
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

	def logar(usuario)
		session[:usuario_id] = usuario.id
		session[:login_time] = Time.now
		@usuario_autenticado = usuario

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
