class CreateConteudos < ActiveRecord::Migration[7.0]
  def change
    create_table :conteudos do |t|
      t.references :unidade_disciplina, null: false, foreign_key: true
      t.string :nome_conteudo

      t.timestamps
    end
  end
end
