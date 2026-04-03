module ApplicationHelper
    def show_svg(path)
        File.open("app/assets/images/#{path}", "rb") do |file|
            raw file.read
        end
    end

	def current_curso(usuario_autenticado)
		if session[:current_curso] != nil then
			return Curso.find_by(id: session[:current_curso])
		else
			isCoordenador = Curso.find_by(usuario_id: usuario_autenticado)
			if isCoordenador then
				return isCoordenador
			else
				isProfessor = Disciplina.find_by(usuario_id: usuario_autenticado)
				if isProfessor then
					session[:current_curso] = isProfessor.curso_id
					return Curso.find(isProfessor.curso_id)
				else
					isEstudante = Matricula.find_by(usuario_id: usuario_autenticado)
					if isEstudante then
						turma = Turma.find(isEstudante.turma_id)
						session[:current_curso] = turma.curso_id
						return Curso.find(turma.curso_id)
					else
						nil
					end
				end
			end
		end
	end

	def turma_estudante(usuario_autenticado, matricula)
		if matricula then
			return Turma.find(matricula.turma_id)
		else
			return nil
		end
	end

	def nome_disciplina_com_turma(disciplina)
		t = Turma.find_by(id: disciplina.turma_id)
		return disciplina.nome_disciplina + " | " + t.nome_turma
	end

	def disciplinas_turma(usuario_autenticado, matricula)
		if matricula then
			return Disciplina.where(
				turma_id: matricula.turma_id,
				semestre: matricula.semestre
				)
		else
			return nil
		end
	end

	def unidades_disciplina(disciplina)
		return UnidadeDisciplina.where(disciplina_id: disciplina.id)
	end

	def conteudos_unidade(unidade)
		return Conteudo.where(unidade_disciplina_id: unidade.id)
	end
end
