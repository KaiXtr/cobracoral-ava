class CreateAnotacaos < ActiveRecord::Migration[7.2]
  def change
    create_table :anotacaos do |t|
      t.references :leitura_conteudo, null: false, foreign_key: true
      t.integer :ln
      t.integer :col
      t.string :cor_anotacao

      t.timestamps
    end
  end
end
