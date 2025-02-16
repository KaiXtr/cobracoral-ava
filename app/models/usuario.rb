class Usuario < ApplicationRecord
	has_many :matricula
	validates_uniqueness_of :email
	
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
