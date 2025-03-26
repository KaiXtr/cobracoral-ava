module TurmaHelper
    def enum_turno(turno)
        hash = Turma.turno_turma_strings.transform_keys(&:to_s)
        return hash[turno + '_string']
    end
    
    def enum_modalidade(modalidade)
        hash = Turma.modalidade_turma_strings.transform_keys(&:to_s)
        return hash[modalidade + '_string']
    end

    def select_turno
        Turma.turno_turmas.map{ |t| [
            enum_turno(t[0]), t[0], {
                'turno-id' => t[0]
            }
        ]}
    end

    def select_modalidade
        Turma.modalidade_turmas.map{ |t| [
            enum_modalidade(t[0]), t[0], {
                'modalidade-id' => t[0]
            }
        ]}
    end
end
