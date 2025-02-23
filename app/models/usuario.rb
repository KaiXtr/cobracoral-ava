class Usuario < ApplicationRecord
	has_many :matricula
	has_many :matricula_cargo, through: :matricula
	has_secure_password

	validates_presence_of :email
	validates_uniqueness_of :email

	validates_presence_of :senha
	
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
