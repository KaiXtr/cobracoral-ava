module ComunicadosHelper
    def usuario_comunicado(usuario_id)
        Usuario.find(usuario_id)
    end

    def info_usuario(usuario)
        disciplina = Disciplina.find_by(usuario_id: usuario.id)
        if disciplina then
            nome_disciplina = disciplina.nome_disciplina
            turma_disciplina = Turma.find(disciplina.turma_id)
            nome_disciplina + " | " + turma_disciplina.nome_turma
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

    def reacoes_quantidade(comunicado, emoji)
        ReacaoComunicado.where(comunicado_id: comunicado.id, emoji: emoji).count()
    end

    def reagir_emoji(comunicado, emoji)
		if session[:usuario_id]
			usuario = Usuario.find(session[:usuario_id])
        end
        reacao = ReacaoComunicado.new(
            usuario_id: usuario.id,
            comunicado_id: comunicado.id,
            emoji: emoji
        )
        reacao.save
    end
end
