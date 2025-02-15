class UsuariosController < ApplicationController
    def index
        # Redirecionar usuário não autenticado
        @usuario_autenticado = usuario_atual
        redirect_to '/entrar' unless @usuario_autenticado
        
        @usuarios = Usuario.all_except(@usuario_autenticado)
    end
  
    def create
        @usuario = Usuario.create(nome_completo: params["usuario"]["nome_completo"])
    end

    def show
        @usuario = Usuario.find(params[:id])
    end
end
