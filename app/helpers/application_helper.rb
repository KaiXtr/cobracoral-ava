module ApplicationHelper
    def show_svg(path)
        File.open("app/assets/images/#{path}", "rb") do |file|
            raw file.read
        end
    end

	def current_curso(usuario_autenticado)
		isCoordenador = Curso.find_by(usuario_id: usuario_autenticado)
		if isCoordenador then
			isCoordenador
		else
			isProfessor = Disciplina.find_by(usuario_id: usuario_autenticado)
			if isProfessor then
				curso_disciplina = Curso.find(isProfessor.curso_id)
			else
				isEstudante = Matricula.find_by(usuario_id: usuario_autenticado)
				if isEstudante then
					turma = Turma.find(isEstudante.turma_id)
					curso_turma = Curso.find(turma.curso_id)
				else
					'Cobracoral'
				end
			end
		end
	end
end
