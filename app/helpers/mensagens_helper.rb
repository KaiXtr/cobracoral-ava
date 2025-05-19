module MensagensHelper
    def formatar_data_mensagem(data_hora)
        data_hora.strftime("%d/%m/%Y - %H:%M")
    end
end
