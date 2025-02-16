class UnidadeDisciplina < ApplicationRecord
  belongs_to :disciplina
  has_many :conteudos
end
