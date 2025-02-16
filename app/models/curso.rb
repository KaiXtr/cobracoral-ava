class Curso < ApplicationRecord
	has_many :turma
	has_many :disciplina
end
