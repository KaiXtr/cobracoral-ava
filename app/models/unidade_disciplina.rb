class UnidadeDisciplina < ApplicationRecord
  belongs_to :disciplina
  has_many :conteudos
  after_create_commit { broadcast_append_to self.disciplina }
end
