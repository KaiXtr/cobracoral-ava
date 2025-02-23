class SobreController < ApplicationController
	before_action :redirecionar_nao_logado

  def index
    @turmas = Turma.all
    @usuarios = Usuario.all_except(@usuario_autenticado)

		Rails.logger.info "Acessando tela 'Sobre'."
  end
end
