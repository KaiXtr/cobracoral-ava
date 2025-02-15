class Conteudo < ApplicationRecord
  belongs_to :unidade_disciplina
  after_create_commit { broadcast_append_to self.unidade_disciplina }
end
