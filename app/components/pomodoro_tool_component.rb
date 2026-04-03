# frozen_string_literal: true

class PomodoroToolComponent < ViewComponent::Base
    def initialize(preferencias_usuario:, login_time:, pomodoris_quant:)
        @pomodoro_pomodoris_tempo = preferencias_usuario.pomodoro_pomodoris_tempo

        t_p = @pomodoro_pomodoris_tempo
        t_d = t_p + preferencias_usuario.pomodoro_descanso
        
        @pomodoro_hora_atual = Time.now
        @pomodoro_hora_inicial = login_time.to_time
        @pomodoro_hora_limite = login_time.to_time + (t_p * 60)
        @pomodoro_tempo_atual = (
            (@pomodoro_hora_atual.to_time - @pomodoro_hora_inicial.to_time).to_i/60
        )

        pomodoris_max = preferencias_usuario.pomodoro_pomodoris_quant

        if @cobra_app_resting then
            @pomodoro_label = "Em descanso"
        else
            @pomodoro_label = "#{pomodoris_max - pomodoris_quant + 1}/#{pomodoris_max}"
        end
    end
end
