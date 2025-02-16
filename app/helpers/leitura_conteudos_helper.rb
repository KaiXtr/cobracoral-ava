module LeituraConteudosHelper
    def get_vencimento_restante(conteudo)
        dataAgora = DateTime.now
        dataConteudo = conteudo.data_vencimento
        diasRestantes = (dataConteudo.to_date - dataAgora.to_date).to_i

        if diasRestantes > 0 then
            return diasRestantes.to_s + ' dias restantes'
        end
        if diasRestantes == 0 then
            return 'Vence hoje'
        end
        if diasRestantes < 0 then
            return 'Atrasado a ' + (diasRestantes * -1).to_s + ' dias'
        end
    end
end
