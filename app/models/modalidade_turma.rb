class ModalidadeTurma < ApplicationRecord
	has_many :turma
	validates_presence_of :enumModalidade
	validates_uniqueness_of :enumModalidade
end
