# frozen_string_literal: true

class MedidorGraficoComponent < ViewComponent::Base
  def initialize(
      medidor_titulo:,
      valor_entrada:,
      valor_tipo:,
      graph_modal: nil)
    @medidor_titulo = medidor_titulo
    @valor_entrada = valor_entrada
    @valor_tipo = valor_tipo
    @graph_modal = graph_modal

    if @valor_tipo == 'porcento' then
      @valor_entrada = valor_entrada.to_s + '%'
    end
    if @valor_tipo == 'minuto' then
      @valor_entrada = valor_entrada.to_s + 'm'
    end
  end
end
