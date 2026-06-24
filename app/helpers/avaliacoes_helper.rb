module AvaliacoesHelper
    def formatar_data_liberacao(data_hora)
        if data_hora then
            data_hora.strftime("Liberado em %d/%m/%Y às %H:%M")
        end
    end

    def formatar_data_vencimento(data_hora)
        if data_hora
            data_hora.strftime("Vence em %d/%m/%Y às %H:%M")
        end
    end

    def is_avaliacao_indisponivel(conteudo)
        dataAgora = DateTime.now
        dataVencimento = conteudo.data_vencimento

        if dataVencimento then
            vencimento = (dataVencimento.to_datetime - dataAgora.to_datetime).to_i

            if vencimento < 0 then
                return true
            else
                dataLiberacao = conteudo.data_liberacao

                if dataLiberacao then
                    liberacao = (dataLiberacao.to_datetime - dataAgora.to_datetime).to_i

                    if liberacao > 0 then
                        return true
                    else
                        return false
                    end
                else
                    return false
                end
            end
        else
            return false
        end
    end

    def conclusao_avaliacao(avaliacao)
        tentativa_avaliacao = TentativaAvaliacao.find_by(
            avaliacao_id: avaliacao.id,
            usuario_id: @usuario.id
        )
        
        if tentativa_avaliacao then
            return true
        else
            return false
        end
    end
end
