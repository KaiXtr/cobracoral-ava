class Curso < ApplicationRecord
	validates_uniqueness_of :cod_curso
	score :all_except, -> (curso) { where.not(id: curso) }
end
