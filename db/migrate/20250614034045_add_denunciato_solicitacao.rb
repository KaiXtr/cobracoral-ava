class AddDenunciatoSolicitacao < ActiveRecord::Migration[7.2]
  def change
    add_reference :solicitacao_denuncia, :solicitacoes, null: false, foreign_key: true
  end
end
