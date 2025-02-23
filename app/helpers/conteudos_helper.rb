module ConteudosHelper
    def formatar_data_liberacao(data_hora)
        data_hora.strftime("Liberado em %d/%m/%Y às %H:%M")
    end

    def formatar_data_vencimento(data_hora)
        data_hora.strftime("Vence em %d/%m/%Y às %H:%M")
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
