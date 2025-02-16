module DisciplinasHelper
    def professor_disciplina(disciplina)
        Usuario.find(disciplina.usuario_id)
    end
    def turma_disciplina(disciplina)
        turma = Turma.find(disciplina.turma_id)
        turma.nome_turma
    end
end
