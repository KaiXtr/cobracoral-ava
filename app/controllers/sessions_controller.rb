require 'net/http'

class SessionsController < ApplicationController
	layout 'login'

	def send_auth_code
		session[:login_email] = params[:session][:email]
		session[:login_senha] = params[:session][:senha]

		if Rails.env.test?
			usuario = Usuario.find_by(email: params[:session][:email])
			session[:auth_code] = (('0'..'9').to_a + ('A'..'Z').to_a).shuffle.first(6).join

			if (usuario && usuario.acessos_count == 0) then
				create()
			else
				SessionMailer.with(
					usuario: usuario,
					codigo: session[:auth_code]
					).codigo_autenticacao_email.deliver_later
				
				redirect_to '/authcode'
			end
		else
			create()
		end
	end

	def auth_code
		if session[:auth_code] == nil then
			redirect_to '/entrar'
		else
			render "auth-code"
		end
	end

	def validate_auth_code
		code_field = ''
		for i in 1..6 do
			code_field += params["auth_code_digit_#{i}"]
		end

		if session[:auth_code] == code_field then
			Rails.logger.info "Código de autenticação válido."
			session[:auth_code] = nil
			create()
		else
			respond_to do |format|
				logtxt = "Código de autenticação incorreto."
				Rails.logger.error logtxt
				format.html { redirect_to "/authcode", notice: logtxt }
				format.json { render json: { error: logtxt }, status: :unauthorized }
			end
		end
	end

	def create
		# Cadastro do usuário inicial administador por API KEY
		if Usuario.all.length == 0 then
			if session[:login_senha] == ENV["COBRACORAL_API_KEY"] then
				usuario = Usuario.new
				usuario.id = 1
				usuario.email = session[:login_email]
				usuario.password = session[:login_senha]
				usuario.pronomes_usuario = :ela_dela
				usuario.cargo_usuario = :coordenador
				usuario.acessos_count = 0
				usuario.save

				Rails.logger.info "Primeiro acesso do usuário administrador."
				session[:primeiro_acesso] = usuario.id
				redirect_to "/primeiro-acesso"
			else
				respond_to do |format|
					logtxt = "Chave de API incorreta"
					Rails.logger.error logtxt
					format.html { redirect_to "/entrar", notice: logtxt }
					format.json { render json: { error: logtxt }, status: :unauthorized }
				end
			end
		
		# Criando sessão para usuário existente
		else
			usuario = Usuario.find_by(email: session[:login_email])

			if usuario then
				if usuario.authenticate(session[:login_senha]) then
					if (usuario.acessos_count == 0) then
						Rails.logger.info "Primeiro acesso do usuário."
						session[:primeiro_acesso] = usuario.id
						redirect_to "/primeiro-acesso"
					else
						logar(usuario, params[:session])
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
	end

	def logar(usuario, sessionData)
		@usuario_autenticado = usuario
		@preferencias_usuario = PreferenciasUsuario.find_by(
			usuario_id: @usuario_autenticado.id
			)

		Conteudo.all.each do |c|
			ConteudoLiberadoJob.set(
				wait_until: Date.tomorrow.at_beginning_of_day
				).perform_later(Conteudo.find(c))
		end

		session[:login_email] = nil
		session[:login_senha] = nil
		session[:primeiro_acesso] = nil
		session[:current_curso] = nil
		session[:usuario_id] = usuario.id
		session[:login_time] = Time.now
		session[:pomodoris_quant] = @preferencias_usuario.pomodoro_pomodoris_quant

		if sessionData != nil then
			session[:login_device] = sessionData[:login_device]
			session[:login_so] = sessionData[:login_so]
			session[:login_browser] = sessionData[:login_browser]

			if @preferencias_usuario.notificacao_novo_acesso then
				SessionMailer.with(
					usuario: usuario,
					login_device: session[:login_device],
					login_so: session[:login_so],
					login_browser: session[:login_browser],
					login_time: Time.now
					).acesso_email.deliver_later
			end
		end
		
		Rails.logger.info "Criada sessão para o(a) usuário(a) com email " + usuario.email + "."
		
		redirect_to root_path
	end

	def primeiro_acesso
		@usuario_autenticado = Usuario.find(session[:primeiro_acesso])

		if @usuario_autenticado.acessos_count > 0 then
			redirect_to root_path
		end

		@cargo = helpers.enum_cargo_usuario(@usuario_autenticado)
		render "primeiro-acesso"
	end

	def recuperar
		if !params[:h] then
			redirect_to "/entrar"
		else
			@usuario_recuperado = Usuario.find_by(password_digest: params[:h])
			
			if @usuario_recuperado then
				session[:email] = @usuario_recuperado.email
				session[:hash_senha] = params[:h]
				render "recuperar"
			else
				respond_to do |format|
					logtxt = "Link de recuperação inválido"
					Rails.logger.error logtxt
					format.html { redirect_to "/recuperar", notice: logtxt }
					format.json { render json: { error: logtxt }, status: :unauthorized }
				end
			end
		end
	end

	def edit
		usuario_autenticado = params[:usuario_autenticado]

		if usuario_autenticado[:nome_completo] == nil ||
			usuario_autenticado[:nome_completo] == '' then
			respond_to do |format|
				logtxt = "Informe seu nome completo."
				Rails.logger.error logtxt
				format.html { redirect_to "/primeiro-acesso", notice: logtxt }
				format.json { render json: { error: usuario.errors }, status: :unauthorized }
			end
		else
			if (usuario_autenticado[:new_password] == usuario_autenticado[:repeat_password])
				usuario = Usuario.find(session[:primeiro_acesso])
				senha_nova = BCrypt::Password.create(usuario_autenticado[:new_password])
				usuario.nome_completo = usuario_autenticado[:nome_completo]
				usuario.pronomes_usuario = usuario_autenticado[:pronomes_usuario]
				usuario.lattes_id = usuario_autenticado[:lattes_id]
				usuario.orcid_id = usuario_autenticado[:orcid_id]
				usuario.password = usuario_autenticado[:new_password]
				usuario.password_digest = senha_nova

				if usuario.save then
					Rails.logger.info "Senha do usuário alterada."
					usuario.acessos_count += 1
					usuario.save

					logar(usuario, params[:session])
				else
					respond_to do |format|
						if usuario.errors["password"] then
							logtxt = "Senha não cumpre os requisitos"
						end
						Rails.logger.error logtxt
						Rails.logger.error usuario.errors
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
	end

	def recover_password
		usuario = Usuario.find_by(email: params[:session][:email])
		
		if usuario then
			#url = URI.parse('http://localhost:8080/solicitacaos/nova')
			#req = Net::HTTP::Post.new(url.to_s)
			#req.body = {
			#	requerente_id: 1,
			#	assunto_solicitacao: 1,
			#	situacao: 'encaminhada',
			#	observacoes: nil
			#}.to_json

			#res = Net::HTTP.start(url.host, url.port) {|http|
			#	http.request(req)
			#}

			session[:login_device] = params[:session][:login_device]
			session[:login_so] = params[:session][:login_so]
			session[:login_browser] = params[:session][:login_browser]
			session[:login_time] = Time.now

			SessionMailer.with(
				usuario: usuario,
				login_device: session[:login_device],
				login_so: session[:login_so],
				login_browser: session[:login_browser],
				login_time: Time.now).recuperacao_senha_email.deliver_later
			
			Rails.logger.info "Enviando solicitação de recuperação de senha para o(a) usuário(a) com email " + usuario.email + "."

			respond_to do |format|
				logtxt = "Solicitação de recuperação de senha foi enviada com sucesso"
				Rails.logger.error logtxt
				format.html { redirect_to "/entrar", notice: logtxt }
				format.json { render json: { notice: logtxt }, status: :ok }
			end
		else
			respond_to do |format|
				logtxt = "Não há usuário cadastrado com o email informado"
				Rails.logger.error logtxt
				format.html { redirect_to "/problemas-acesso", notice: logtxt }
				format.json { render json: { error: logtxt }, status: :unauthorized }
			end
		end
	end

	def validate_recovery
		hash_senha = session[:hash_senha]

		if !hash_senha then
			respond_to do |format|
				logtxt = "Link de recuperação de senha inválido."
				Rails.logger.error logtxt
				format.html { redirect_to "/entrar", notice: logtxt }
				format.json { render json: { error: logtxt }, status: :unauthorized }
			end
		else
			usuario = Usuario.find_by(password_digest: hash_senha)

			if usuario then
				usuario_recuperado = params[:usuario_recuperado]

				if (usuario_recuperado[:new_password] == usuario_recuperado[:repeat_password])
					senha_nova = BCrypt::Password.create(usuario_recuperado[:new_password])
					usuario.password = usuario_recuperado[:new_password]
					usuario.password_digest = senha_nova

					if usuario.save then
						Rails.logger.info "Senha do usuário alterada."
						usuario.acessos_count += 1
						usuario.save

						logar(usuario, nil)
					else
						respond_to do |format|
							if usuario_recuperado.errors["password"] then
								logtxt = "Senha não cumpre os requisitos"
							else
								logtxt = usuario_recuperado.errors
							end
							Rails.logger.error logtxt
							format.html { redirect_to "/recuperar?h=" + hash_senha, notice: logtxt }
							format.json { render json: { error: usuario_recuperado.errors }, status: :unauthorized }
						end
					end
				else
					respond_to do |format|
						logtxt = "As senhas não conferem."
						Rails.logger.error logtxt
						format.html { redirect_to "/recuperar?h=" + hash_senha, notice: logtxt }
						format.json { render json: { error: usuario_recuperado.errors }, status: :unauthorized }
					end
				end
			else
				respond_to do |format|
					logtxt = "Link de recuperação de senha inválido."
					Rails.logger.error logtxt
					format.html { redirect_to "/entrar", notice: logtxt }
					format.json { render json: { error: logtxt }, status: :unauthorized }
				end
			end
		end
	end
	
	def destroy
		logout if logado?
		Rails.logger.info "Destruindo sessão de usuário."
		redirect_to root_path
	end
end
