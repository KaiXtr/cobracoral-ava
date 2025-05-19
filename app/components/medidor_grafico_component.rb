# frozen_string_literal: true

class MedidorGraficoComponent < ViewComponent::Base
  def initialize(
      medidor_titulo:,
      valor_entrada:,
      valor_tipo:,
      valor_max: 100,
      modal_href: nil,
      theme: 0)
    @medidor_titulo = medidor_titulo
    @valor_entrada = valor_entrada
    @label_entrada = valor_entrada
    @valor_tipo = valor_tipo
    @valor_max = valor_max
    @modal_href = modal_href

    if @valor_tipo == 'nota' then
      @valor_entrada = @valor_entrada * 10
    elsif @valor_tipo == 'porcento' then
      @label_entrada = @valor_entrada.to_s + '%'
    elsif @valor_tipo == 'minuto' then
      horas = 0
      minutos = 0

      while @label_entrada > 60 do
        horas += 1
        @label_entrada -= 60
      end

      minutos = @label_entrada

      if horas > 0 then
        @label_entrada = horas.to_s + 'h' + minutos.to_s + 'm'
      else
        @label_entrada = @label_entrada.to_s + 'm'
      end

      if @valor_entrada > 0 then
        @valor_entrada = 100/(@valor_max/@valor_entrada)
      end
    end

    if theme == 0 then
      @medidor_style = "background: conic-gradient(var(--main-color) " + @valor_entrada.to_s + "%, white 0) !important"
    elsif theme == 1 then
      @medidor_style = "background: conic-gradient(var(--red-dark) " + @valor_entrada.to_s + "%, var(--white-main) 0) !important"
    end
  end
end
