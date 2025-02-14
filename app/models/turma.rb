class Turma < ApplicationRecord
	validates_uniqueness_of :cod_turma
	scope :all_except, ->(turma) { where.not(id: turma) }
end
