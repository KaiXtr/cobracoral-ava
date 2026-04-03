class CreateSolicitacoes < ActiveRecord::Migration[7.2]
  def change
    create_table :solicitacoes do |t|
      t.string :situacao
      t.text :observacoes

      t.timestamps
    end
  end
end
