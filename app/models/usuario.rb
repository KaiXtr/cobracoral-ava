class Usuario < ApplicationRecord
	has_many :matricula
	has_many :matricula_cargo, through: :matricula
	has_one_attached :avatar
	has_secure_password

	validates_presence_of :email
	validates_uniqueness_of :email

	validates_presence_of :password_digest

	validates :password, format: /\A
		(?=.{8,})
		(?=.*\d)
		(?=.*[a-z])
		(?=.*[A-Z])
	/x
	
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
