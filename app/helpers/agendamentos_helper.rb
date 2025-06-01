module AgendamentosHelper
    def formatar_data_semana(data)
        return data.strftime("%d/%m")
    end

    def formatar_data_hora_agendamento(agendamento)
        label_data_hora_inicio = agendamento.data_inicio.strftime("%d/%m/%Y")
        label_data_hora_fim = agendamento.data_fim.strftime("%d/%m/%Y")

        if agendamento.horario_inicio then
            label_data_hora_inicio += " - " + agendamento.horario_inicio.strftime("%H:%M")
        end
        if agendamento.horario_fim then
            label_data_hora_fim += " - " + agendamento.horario_fim.strftime("%H:%M")
        end

        return label_data_hora_inicio + " | " + label_data_hora_fim
    end

    def formatar_hora_agendamento(agendamento)
        if agendamento.horario_fim then
            horario_inicio = agendamento.horario_inicio.strftime("%H:%M")
            horario_fim = agendamento.horario_fim.strftime("%H:%M")
            return horario_inicio + " | " + horario_fim

        elsif agendamento.horario_inicio then
            return agendamento.horario_inicio.strftime("%H:%M")

        else
            return ''
        end
    end

    def local_agendamento_label(agendamento)
        if agendamento.local_agendamento_id then
            local_agendamento = LocalAgendamento.find(agendamento.local_agendamento_id)
            return local_agendamento.edificio + " | " + local_agendamento.local
        else
            return 'Remoto'
        end
    end
end