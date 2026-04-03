class Anotacao < ApplicationRecord
  belongs_to :leitura_conteudo
  has_rich_text :corpo_anotacao
end
