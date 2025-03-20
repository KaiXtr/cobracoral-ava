class TurnoTurma < ApplicationRecord
	has_many :turma
	validates_presence_of :enumTurno
	validates_uniqueness_of :enumTurno
end
