class Conteudo < ApplicationRecord
  belongs_to :unidade_disciplina
  has_many :leitura_conteudo
end
