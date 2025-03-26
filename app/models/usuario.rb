class Usuario < ApplicationRecord
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

	enum :pronomes_usuario, [
		:ela_dela,
		:ele_dele,
		:elu_delu
	]

	enum :cargo_usuario, [
		:administrador,
		:coordenador,
		:professor,
		:representante,
		:estagiario,
		:monitor,
		:estudante,
	]

	def self.pronomes_usuario_strings
		return {
			ela_dela_string: 'Ela/dela',
			ele_dele_string: 'Ele/dele',
			elu_delu_string: 'Elu/delu'
		}
	end

	def self.cargo_usuario_feminino_strings
		return {
			administrador_feminino_string: 'Administradora',
			coordenador_feminino_string: 'Coordenadora',
			professor_feminino_string: 'Professora',
			representante_feminino_string: 'Representante',
			estagiario_feminino_string: 'Estagiária',
			monitor_feminino_string: 'Monitora',
			estudante_feminino_string: 'Estudante',
		}
	end

	def self.cargo_usuario_masculino_strings
		return {
			administrador_masculino_string: 'Administrador',
			coordenador_masculino_string: 'Coordenador',
			professor_masculino_string: 'Professor',
			representante_masculino_string: 'Representante',
			estagiario_masculino_string: 'Estagiário',
			monitor_masculino_string: 'Monitor',
			estudante_masculino_string: 'Estudante',
		}
	end
	
	scope :all_except, -> (usuario) { where.not(id: usuario) }
end
