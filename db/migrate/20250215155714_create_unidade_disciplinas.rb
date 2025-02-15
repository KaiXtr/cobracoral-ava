class CreateUnidadeDisciplinas < ActiveRecord::Migration[7.0]
  def change
    create_table :unidade_disciplinas do |t|
      t.references :disciplina, null: false, foreign_key: true
      t.string :nome_unidade

      t.timestamps
    end
  end
end
