class Mensagem < ApplicationRecord
  #belongs_to :usuario, foreign_key: "remetente"
  #belongs_to :usuario, foreign_key: "destinatario"
  has_many :reacao_mensagens
  has_rich_text :corpo

  self.table_name = "mensagens"
  
  def to_partial_path 
    'mensagens/mensagem' 
  end

  def to_show_path 
    'mensagens/show' 
  end

  after_create_commit -> {
    broadcast_prepend_to "mensagens",
      partial: "mensagens/mensagem",
      locals: { mensagem: self },
      target: "mensagens"
  }
end
