class CreateSemestres < ActiveRecord::Migration[7.2]
  def change
    create_table :semestres do |t|
      t.string :nome_semestre
      t.datetime :dia_inicio
      t.datetime :dia_fim

      t.timestamps
    end
  end
end
