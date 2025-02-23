class IdeController < ApplicationController
	before_action :redirecionar_nao_logado

  def index
    Rails.logger.info "Acessando ambiente integrado de desenvolvimento."
  end
end
