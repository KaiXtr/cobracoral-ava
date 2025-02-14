class Curso < ApplicationRecord
	validates_uniqueness_of :cod_curso
	scope :all_except, -> (curso) { where.not(id: curso) }
end
