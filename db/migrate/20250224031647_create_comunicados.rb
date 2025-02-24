class CreateComunicados < ActiveRecord::Migration[7.0]
  def change
    create_table :comunicados do |t|
      t.references :usuario, null: false, foreign_key: true
      t.references :turma, null: false, foreign_key: true
      t.text :conteudo
      t.string :url_img

      t.timestamps
    end
  end
end
