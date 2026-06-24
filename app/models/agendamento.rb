class Agendamento < ApplicationRecord
	belongs_to :usuario
	belongs_to :local_agendamento, optional: true
	has_rich_text :descricao_agendamento
	
	validates_presence_of :data_inicio
	validates_presence_of :data_fim

	enum :repete, [
		:todo_dia,
		:toda_semana,
		:todo_mes,
		:todo_ano
	]
end
