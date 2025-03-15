module LeituraConteudosHelper
    def diaOuDias(dias)
        return (dias == -1) ? ' dia' : ' dias'
    end

    def get_vencimento_restante(conteudo)
        dataAgora = DateTime.now
        dataLiberacao = conteudo.data_liberacao
        dataVencimento = conteudo.data_vencimento

        if !dataLiberacao && !dataVencimento then
            return ''
        end

        if dataLiberacao then
            diasLiberacao = (dataAgora.to_date - dataLiberacao.to_date).to_i

            if diasLiberacao < 0 then
                return 'Liberado em ' + (-diasLiberacao).to_s + diaOuDias(diasLiberacao)
            end
        end

        if dataVencimento then
            diasVencimento = (dataVencimento.to_date - dataAgora.to_date).to_i

            if diasVencimento > 0 then
                return diasVencimento.to_s + diaOuDias(diasVencimento) + ' restantes'
            end
            if diasVencimento == 0 then
                return 'Vence hoje'
            end
            if diasVencimento < 0 then
                return 'Atrasado a ' + (diasVencimento * -1).to_s + diaOuDias(diasVencimento)
            end
        else
            return ''
        end
    end
end
