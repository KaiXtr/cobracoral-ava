module TurmaHelper
    def enum_turno(turno)
        return Turma.turno_turma_strings[turno + '_string']
    end
    
    def enum_modalidade(modalidade)
        return Turma.modalidade_turma_strings[modalidade + '_string']
    end
end
