class QuestaoAvaliacao < ApplicationRecord
  self.table_name = "questao_avaliacoes"

  belongs_to :avaliacao
  has_many :alternativa_questao
  has_many :resposta_tentativa
  
  has_rich_text :corpo_questao
end
