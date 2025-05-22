class Agendamento < ApplicationRecord
  belongs_to :usuario
  belongs_to :local_agendamento

	validates_presence_of :local_agendamento
	validates_presence_of :data_inicio
	validates_presence_of :data_fim
end
