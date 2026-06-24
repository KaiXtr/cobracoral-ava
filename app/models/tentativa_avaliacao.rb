class TentativaAvaliacao < ApplicationRecord
  self.table_name = "tentativa_avaliacoes"

  belongs_to :usuario
  belongs_to :avaliacao
  has_many :resposta_tentativa
end
