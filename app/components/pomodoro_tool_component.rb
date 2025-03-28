# frozen_string_literal: true

class PomodoroToolComponent < ViewComponent::Base
    def initialize(login_time:)
        @pomodoro_ativado = true
        @pomodoro_hora_atual = Time.now
        @pomodoro_hora_inicial = login_time.to_time
        @pomodoro_hora_limite = login_time.to_time + (15 * 60)
        @pomodoro_tempo_atual = (
            (@pomodoro_hora_atual.to_time - @pomodoro_hora_inicial.to_time).to_i/60
        )
    end
end
