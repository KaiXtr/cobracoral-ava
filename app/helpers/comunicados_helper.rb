module ComunicadosHelper
    def usuario_comunicado(usuario_id)
        Usuario.find(usuario_id)
    end
    
    def enum_visibilidade(visibilidade)
        return Comunicado.visibilidade_comunicado_strings[visibilidade + '_string']
    end

    def info_usuario(usuario, comunicado)
        visibilidade = comunicado.visibilidade_comunicado
        disciplina = Disciplina.find_by(usuario_id: usuario.id)

        # Professor(a) da disciplina
        if disciplina then
            # Visível para todos da disciplina
            if visibilidade == 4
                nome_disciplina = disciplina.nome_disciplina
                turma_disciplina = Turma.find(disciplina.turma_id)
                nome_disciplina + " | " + turma_disciplina.nome_turma
            else
                # Visível para todos de uma turma
                if visibilidade == 3
                    turma_disciplina = Turma.find(comunicado.turma_id)
                    turma_disciplina.nome_turma
                # Visível para todas as turmas
                else
                    'Várias turmas'
                end
            end
        # Coordenador(a) do curso
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
