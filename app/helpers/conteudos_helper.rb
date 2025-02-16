module ConteudosHelper
    def conclusao_conteudo(conteudo)
        leitura_conteudo = LeituraConteudo.find_by(
            conteudo_id: conteudo.id,
            usuario_id: @usuario.id
          )
        return leitura_conteudo.conclusao == 1
    end
end
