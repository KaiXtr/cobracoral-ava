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

        if comunicado then
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
                if disciplina_comunicado then
                    nome_disciplina = disciplina_comunicado.nome_disciplina
                    turma_disciplina = Turma.find_by(id: disciplina_comunicado.turma_id)
                    return nome_disciplina + " | " + turma_disciplina.nome_turma
                else
                    return ''
                end
            end
        end
    end

    def formatar_data_publicacao(data_hora)
        data_hora.strftime("Publicado em %d/%m/%Y às %H:%M")
    end

    def reacoes_comunicado_quantidade(comunicado, emoji)
        ReacaoComunicado.where(comunicado_id: comunicado.id, emoji: emoji).count()
    end

    def reagir_emoji_comunicado(comunicado, emoji)
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

    def get_lista_usuarios_notificados(usuario_autenticado, comunicado)
        usuarios_list = Array.new()

        if comunicado.visibilidade_comunicado == "todos_curso" then
            curso_comunicado = Curso.find_by(usuario_id: usuario_autenticado.id)
            turmas_curso = Turma.where(curso_id: curso_comunicado.id)
            turmas_curso.each do |t|
                usuarios_list += Usuario.joins(:matricula).where(matricula: {turma_id: t.id})
        end
        elsif comunicado.visibilidade_comunicado == "todas_turmas" then
            usuarios_list = Usuario.all
        elsif comunicado.visibilidade_comunicado == "todos_turma" then
            usuarios_list += Usuario.joins(:matricula).where(
                matricula: { turma_id: comunicado.turma_id }
                )
        elsif comunicado.visibilidade_comunicado == "todos_disciplina" then
            disciplina = Disciplina.find(comunicado.disciplina_id)
            usuarios_list += Usuario.joins(:matricula).where(
                matricula: { turma_id: disciplina.turma_id }
                )
        else
            usuarios_list = Usuario.all.select(:id, :email).take
        end

        return usuarios_list
    end
end
