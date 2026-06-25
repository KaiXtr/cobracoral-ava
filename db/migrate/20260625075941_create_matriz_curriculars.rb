class CreateMatrizCurriculars < ActiveRecord::Migration[7.2]
  def change
    create_table :matriz_curriculars do |t|
      t.references :curso, null: false, foreign_key: true
      t.string :nome_matriz

      t.timestamps
    end
  end
end
