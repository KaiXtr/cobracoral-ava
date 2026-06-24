# frozen_string_literal: true

module AvaliacaoNavButton
  class AvaliacaoNavButtonComponent < ViewComponent::Base
    def initialize(avaliacao:, questao:, pagina:)
      @avaliacao = avaliacao
      @questao = questao
      @pagina = pagina

      @max_questoes = avaliacao.quant_questoes
    end
  end
end
