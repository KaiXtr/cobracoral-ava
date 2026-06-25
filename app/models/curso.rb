class Curso < ApplicationRecord
	belongs_to :usuario
	
	has_many :turma
	has_many :disciplina
	has_many :matriz_curricular
end
