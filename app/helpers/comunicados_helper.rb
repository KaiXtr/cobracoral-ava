module ComunicadosHelper
    def usuario_comunicado(usuario_id)
        Usuario.find(usuario_id)
    end

    def info_usuario(usuario)
        disciplina = Disciplina.find_by(usuario_id: usuario.id)
        if disciplina then
            disciplina.nome_disciplina
        else
            curso = Curso.find_by(usuario_id: usuario.id)
            if curso then
                "Coordenação de " + curso.nome_curso
            end
        end
    end

    def formatar_data_publicacao(data_hora)
        data_hora.strftime("Publicado em %d/%m/%Y às %H:%M")
    end
end
