class RespostaTentativa < ApplicationRecord
    belongs_to :tentativa_avaliacao
    belongs_to :questao_avaliacao
    belongs_to :alternativa_questao
end
