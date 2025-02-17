class Usuario < ApplicationRecord
	has_many :matricula
	has_many :matricula_cargo, through: :matricula

	validates_presence_of :email
	validates_uniqueness_of :email
	
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
