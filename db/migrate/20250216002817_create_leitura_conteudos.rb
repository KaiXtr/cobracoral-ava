class CreateLeituraConteudos < ActiveRecord::Migration[7.0]
  def change
    create_table :leitura_conteudos do |t|
      t.references :conteudo, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true
      t.integer :conclusao

      t.timestamps
    end
  end
end
