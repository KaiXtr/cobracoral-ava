class AlternativaQuestao < ApplicationRecord
    self.table_name = "alternativa_questoes"

    belongs_to :questao_avaliacao
    has_rich_text :label_alternativa
    has_rich_text :explicacao_alternativa
end
