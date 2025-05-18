module ComunicadosHelper
    def usuario_comunicado(usuario_id)
        Usuario.find(usuario_id)
    end
    
    def enum_visibilidade(visibilidade)
        hash = Comunicado.visibilidade_comunicado_strings.transform_keys(&:to_s)
        return hash[visibilidade + '_string']
    end

    def select_visibilidade(visibilidades)
        visibilidades.map{ |v| [
            enum_visibilidade(v[0]), v[0], {
                'visibilidade-id' => v[0]
            }
        ]}
    end

    def info_usuario(usuario, comunicado)
        visibilidade = comunicado.visibilidade_comunicado
        puts "Visibilidade é " + visibilidade
        
        # Visível para todos de um curso
        if visibilidade == 'todos_curso'
            curso_comunicado = Curso.find_by(usuario_id: usuario.id)
            return "Coordenação de " + curso_comunicado.nome_curso
        # Visível para todas as turmas em que leciona
        elsif visibilidade == 'todas_turmas'
            return "Várias turmas"
        # Visível para todos de uma turma X
        elsif visibilidade == 'todos_turma'
            turma_disciplina = Turma.find_by(id: comunicado.turma_id)
            return turma_disciplina.nome_turma
        # Visível para todos de uma disciplina X
        elsif visibilidade == 'todos_disciplina'
            disciplina_comunicado = Disciplina.find_by(id: comunicado.disciplina_id)
            nome_disciplina = disciplina_comunicado.nome_disciplina
            turma_disciplina = Turma.find_by(id: disciplina_comunicado.turma_id)
            return nome_disciplina + " | " + turma_disciplina.nome_turma
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
