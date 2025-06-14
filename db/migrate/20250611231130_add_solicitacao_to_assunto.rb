class AddSolicitacaoToAssunto < ActiveRecord::Migration[7.2]
  def change
    add_reference :solicitacoes, :usuario, null: false, foreign_key: true
    add_reference :solicitacoes, :assunto_solicitacoes, null: false, foreign_key: true
  end
end
