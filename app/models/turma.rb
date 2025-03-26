class Turma < ApplicationRecord
    belongs_to :curso

    has_many :matricula
    has_many :disciplina
    has_many :comunicado

	enum :turno_turma, {
		diurno: 'Diurno',
		vespertino: 'Vespertino',
		noturno: 'Noturno',
    }

	enum :modalidade_turma, {
		presencial: 'Presencial',
		ead: 'EaD',
    }
end
