class Conteudo < ApplicationRecord
  belongs_to :unidade_disciplina
  has_many :leitura_conteudo
  has_rich_text :corpo
end
