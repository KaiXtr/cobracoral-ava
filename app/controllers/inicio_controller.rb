class InicioController < ApplicationController
  def index
    @current_user = usuario_atual
    redirect_to '/entrar' unless @current_user
    @turmas = Turma.all
    @usuarios = Usuario.all_except(@current_user)
  end
end
