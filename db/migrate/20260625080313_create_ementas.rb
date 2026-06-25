class CreateEmentas < ActiveRecord::Migration[7.2]
  def change
    create_table :ementas do |t|
      t.references :matriz_curricular, null: false, foreign_key: true
      t.references :semestre, null: false, foreign_key: true
      t.string :nome_ementa
      t.integer :carga_horaria
      t.text :objetivos
      t.text :metodologia

      t.timestamps
    end
  end
end
