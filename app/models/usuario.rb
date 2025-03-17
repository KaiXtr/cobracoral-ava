class Usuario < ApplicationRecord
	belongs_to :pronomes_usuario
	belongs_to :usuario_cargo

	has_many :curso
	has_many :disciplina
	has_many :matricula
	has_many :leitura_conteudo
	has_many :comunicado
	has_many :reacao_comunicado

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
