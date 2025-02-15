class SobreController < ApplicationController
  def index
    @usuario_autenticado = usuario_autenticado
    redirect_to '/entrar' unless @usuario_autenticado
    @turmas = Turma.all
    @usuarios = Usuario.all_except(@usuario_autenticado)
  end
end
