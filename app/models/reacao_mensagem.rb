class ReacaoMensagem < ApplicationRecord
  belongs_to :mensagem
  belongs_to :usuario

  self.table_name = "reacao_mensagens"
end
