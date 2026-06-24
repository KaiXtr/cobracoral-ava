require "action_text"

class ApplicationController < ActionController::Base
	include Pundit::Authorization
	helper ActionText::Engine.helpers

	before_action :set_cobra_app_theme, :set_cobra_app_resting

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
		def set_cobra_app_theme
			@cobra_app_theme = "theme-default"
			@usuario_autenticado = get_usuario_autenticado

			if (@usuario_autenticado) then
				@preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: @usuario_autenticado.id)

				if (@preferencias_usuario) then
					@cobra_app_theme = "theme-" + @preferencias_usuario.tema
				end
			end
		end

		def set_cobra_app_resting
			@cobra_app_resting = false
			@usuario_autenticado = get_usuario_autenticado

			if (@usuario_autenticado) then
				@preferencias_usuario = PreferenciasUsuario.find_by(usuario_id: @usuario_autenticado.id)

				login_time = session[:login_time]

				if (@preferencias_usuario.pomodoro_ativar && login_time) then
					t_p = @preferencias_usuario.pomodoro_pomodoris_tempo
					t_d = t_p + @preferencias_usuario.pomodoro_descanso

					@pomodoro_hora_atual = Time.now
					@pomodoro_hora_inicial = login_time.to_time
					@pomodoro_hora_descanso = login_time.to_time + (t_p * 60)
					@pomodoro_hora_retorno = login_time.to_time + (t_d * 60)
					@pomodoro_tempo_atual = (
						(@pomodoro_hora_atual.to_time - @pomodoro_hora_inicial.to_time).to_i/60
					)

					@pomodoro_tempo_descanso = (
						(@pomodoro_hora_retorno.to_time - @pomodoro_hora_atual.to_time).to_i/60
					)

					if (@pomodoro_hora_atual >= @pomodoro_hora_descanso) &&
					(@pomodoro_hora_atual < @pomodoro_hora_retorno) then
						if (@preferencias_usuario.pomodoro_hibernar) then
							@cobra_app_resting = true
						end
					end

					if (@pomodoro_hora_atual >= @pomodoro_hora_retorno) then
						session[:login_time] = Time.now
						if (session[:pomodoris_quant]) then
							session[:pomodoris_quant] = session[:pomodoris_quant] - 1
							
							if (session[:pomodoris_quant] <= 0) then
								if (@preferencias_usuario.pomodoro_logoff) then
									logoff
								else
									session[:pomodoris_quant] = @preferencias_usuario.pomodoro_pomodoris_quant
								end
							end
						end
					end
				end
			end
		end
end
