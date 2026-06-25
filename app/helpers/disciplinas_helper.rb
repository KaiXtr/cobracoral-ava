module DisciplinasHelper
    def professor_disciplina(disciplina)
        Usuario.find(disciplina.usuario_id)
    end

    def turma_disciplina(disciplina)
        Turma.find(disciplina.turma_id)
    end

    def semestre_disciplina(disciplina)
        Semestre.find(disciplina.semestre_id)
    end
end
