class Solicitacao < ApplicationRecord
  self.table_name = "solicitacoes"

  has_many_attached :anexos
  belongs_to :usuario
  has_one :assunto_solicitacao
  has_many :solicitacao_denuncia
end
