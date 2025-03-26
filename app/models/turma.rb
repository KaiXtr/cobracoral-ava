class Turma < ApplicationRecord
    belongs_to :curso

    has_many :matricula
    has_many :disciplina
    has_many :comunicado

	enum :turno_turma, [
		:diurno,
		:vespertino,
		:noturno,
	]

	enum :modalidade_turma, [
		:presencial,
		:ead,
	]

	enum :turno_turma_string, {
		diurno_string: 'Diurno',
		vespertino_string: 'Vespertino',
		noturno_string: 'Noturno',
    }

	enum :modalidade_turma_string, {
		presencial_string: 'Presencial',
		ead_string: 'Ensino à distância',
    }
end
