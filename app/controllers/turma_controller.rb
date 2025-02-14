class TurmaController < ApplicationController
  def index
	@current_user = usuario_atual
	@turma = Turma.new

	redirect_to '/entrar' unless @current_user
	@turmas = Turma.all
	@usuario = Usuario.all_except(@current_user)
  end

  def criar_turma
	@turma = Turma.create(nome_turma: params["turma"]["nome_turma"])
  end
end
