class Usuario < ApplicationRecord
	validates_uniqueness_of :email
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
