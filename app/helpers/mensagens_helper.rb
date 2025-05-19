module MensagensHelper
    def formatar_data_mensagem(data_hora)
        data_agora = DateTime.now
        tempo_mensagem = (data_agora.to_time - data_hora.to_time).to_i

        if (tempo_mensagem > 60*60*24) then
            return 'Ontem'
        else
            return data_hora.strftime("%H:%M")
        end
    end
end
