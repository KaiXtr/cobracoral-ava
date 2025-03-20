class UsuariosExtController < ApplicationController
	def get_auth_token
        # OBTER USUÁRIO ATRAVÉS DO PORTAL DO DESENVOLVEDOR COBRACORAL, ONDE FOI GERADA A API_KEY
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

    def get_usuarios
		respond_to do |format|
			format.json { render json: { usuarios: Usuario.all }, status: :ok }
		end
    end

    def create_usuario
        json_params = JSON.parse(request.raw_post)
        novo_usuario = Usuario.new
        novo_usuario.nome_completo = json_params['nome']
        novo_usuario.pronomes_usuario_id = json_params['pronomes']
        novo_usuario.email = json_params['email']
        novo_usuario.password = json_params['senha']
        novo_usuario.usuario_cargo_id = json_params['cargo']
        novo_usuario.acessos_count = 0
        
        if novo_usuario.save then
            if novo_usuario.pronomes_usuario_id == 1 then
                logtxt = "[EXT] Usuária " + novo_usuario.nome_completo + " cadastrada com sucesso."
            else
                logtxt = "[EXT] Usuário " + novo_usuario.nome_completo + " cadastrado com sucesso."
            end
            respond_to do |format|
                format.json { render json: novo_usuario, status: :ok }
            end
        else
            Rails.logger.error "[EXT] Houve um erro ao cadastrar o usuário."
            respond_to do |format|
                format.json { render json: {
                    json: json_params,
                    erros: novo_usuario.errors
                }, status: :bad_request }
            end
        end
    end
end
