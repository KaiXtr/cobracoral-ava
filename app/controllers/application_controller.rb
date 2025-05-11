require "action_text"

class ApplicationController < ActionController::Base
	include Pundit::Authorization
	helper ActionText::Engine.helpers

	before_action :set_cobra_app_resting

	def get_usuario_autenticado
		if session[:usuario_id]
			if Usuario.where(id: session[:usuario_id]).length > 0 then
				@usuario_autenticado = Usuario.find(session[:usuario_id])
				@preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: @usuario_autenticado.id)
				if (!@preferencias_usuario) then
					@preferencias_usuario = PreferenciasUsuario.new(usuario_id: session[:usuario_id])
				end
				return @usuario_autenticado
			else
				Rails.logger.info "Usuário previamente autenticado foi deletado."
				logout
			end
		end
	end

    def redirecionar_nao_logado
        @usuario_autenticado = get_usuario_autenticado
		if !@usuario_autenticado then
			Rails.logger.info "Usuário não autenticado. Redirecionando."
        	redirect_to '/entrar'
		end
    end

	def current_user
		get_usuario_autenticado
	end

	def index
		@usuario_autenticado = get_usuario_autenticado
	end

	def show
		@usuario_autenticado = get_usuario_autenticado
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
		!get_usuario_autenticado.nil?
	end

	def logout
		session.delete(:usuario_id)
		@usuario_autenticado = nil
		Rails.logger.info "Encerrando sessão."
	end

	private

		def set_cobra_app_resting
			@cobra_app_resting = false

			login_time = session[:login_time]

			if (login_time) then
				@pomodoro_hora_atual = Time.now
				@pomodoro_hora_inicial = login_time.to_time
				@pomodoro_hora_descanso = login_time.to_time + (25 * 60)
				@pomodoro_hora_retorno = login_time.to_time + (30 * 60)
				@pomodoro_tempo_atual = (
					(@pomodoro_hora_atual.to_time - @pomodoro_hora_inicial.to_time).to_i/60
				)

				if (@pomodoro_hora_atual >= @pomodoro_hora_descanso) &&
				(@pomodoro_hora_atual < @pomodoro_hora_retorno) then
					@cobra_app_resting = true
				end

				if (@pomodoro_hora_atual >= @pomodoro_hora_retorno) then
					session[:login_time] = Time.now
				end
			end
		end
end
