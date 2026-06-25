# frozen_string_literal: true

module AvaliacaoTimer
    class AvaliacaoTimerComponent < ViewComponent::Base
        def initialize(tentativa_inicio:, tempo_limite:)
            @hora_atual = Time.now
            @tempo_inicial = tentativa_inicio.to_time
            @tempo_max = tentativa_inicio.to_time + tempo_limite
            @tempo_atual = (
                (@hora_atual.to_time - @tempo_inicial.to_time).to_i/60
            )

            @tempo_limite = tempo_limite
        end
    end
end
