class ModalidadeTurma < ApplicationRecord
	validates_presence_of :enumModalidade
	validates_uniqueness_of :enumModalidade
end
