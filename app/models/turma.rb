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

	def self.turno_turma_strings
		return {
			diurno_string: 'Diurno',
			vespertino_string: 'Vespertino',
			noturno_string: 'Noturno',
		}
	end

	def self.modalidade_turma_strings
		return {
			presencial_string: 'Presencial',
			ead_string: 'Ensino à distância',
		}
	end
end
