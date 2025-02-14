class Usuario < ApplicationRecord
	validates_uniqueness_of :usuario
	scope: all_except, ->(usuario) { where.not(id: usuario) }
end
