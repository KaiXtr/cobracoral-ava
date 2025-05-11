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
      horas = 0
      minutos = 0

      while @valor_entrada > 60 do
        horas += 1
        @valor_entrada -= 60
      end

      minutos = @valor_entrada

      if horas > 0 then
        @valor_entrada = horas.to_s + 'h' + minutos.to_s + 'm'
      else
        @valor_entrada = valor_entrada.to_s + 'm'
      end
    end
  end
end
