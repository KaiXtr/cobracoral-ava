module ConteudosHelper
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
