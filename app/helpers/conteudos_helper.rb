module ConteudosHelper
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

    def is_conteudo_indisponivel(conteudo)
        dataAgora = DateTime.now
        dataVencimento = conteudo.data_vencimento

        if dataVencimento then
            vencimento = (dataVencimento.to_date - dataAgora.to_date).to_i

            if vencimento < 0 then
                return true
            else
                dataLiberacao = conteudo.data_liberacao

                if dataLiberacao then
                    liberacao = (dataLiberacao.to_date - dataAgora.to_date).to_i

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

    def conclusao_conteudo(conteudo)
        leitura_conteudo = LeituraConteudo.find_by(
            conteudo_id: conteudo.id,
            usuario_id: @usuario.id
        )
        
        if leitura_conteudo then
            return leitura_conteudo.conclusao == 1
        else
            return false
        end
    end
end
