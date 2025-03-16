class PainelController < ApplicationController
	before_action :redirecionar_nao_logado

  def index
    @usuario_autenticado = usuario_autenticado

		Rails.logger.info "Acessando painel."
  end
end
