class TurmaController < ApplicationController
  def index
	@current_user = usuario_atual
	redirect_to '/entrar' unless @current_user
	@turmas = Turma.all
	@usuario = Usuario.all_except(@current_user)
  end
end
