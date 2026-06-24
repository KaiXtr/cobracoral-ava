# frozen_string_literal: true

module MedidorBarra
  class MedidorBarraComponent < ViewComponent::Base
    def initialize(
        valor_entrada:,
        valor_max: 100)
      @valor_entrada = valor_entrada
      @valor_max = valor_max
    end
  end
end
