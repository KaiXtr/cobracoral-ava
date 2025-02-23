class ApplicationController < ActionController::Base
	include Pundit::Authorization

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
		@usuario_autenticado = usuario
		Rails.logger.info "Criada sessão para o(a) usuário(a) com email " + params[:session][:email]
		redirect_to root_path
	end

	def logado?
		!usuario_autenticado.nil?
	end

	def logout
		session.delete(:usuario_id)
		@usuario_autenticado = nil
	end
end
