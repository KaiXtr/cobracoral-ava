class CreateSolicitacaoDenuncia < ActiveRecord::Migration[7.2]
  def change
    create_table :solicitacao_denuncia do |t|
      t.string :nome_envolvido
      t.date :data_ocorrido
      t.string :tipo_denuncia
      t.text :descricao

      t.timestamps
    end
  end
end
