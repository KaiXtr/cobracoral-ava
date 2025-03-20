class Curso < ApplicationRecord
	belongs_to :usuario
	
	has_many :turma
	has_many :disciplina
end
