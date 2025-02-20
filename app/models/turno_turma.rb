class TurnoTurma < ApplicationRecord
	validates_presence_of :enumTurno
	validates_uniqueness_of :enumTurno
end
