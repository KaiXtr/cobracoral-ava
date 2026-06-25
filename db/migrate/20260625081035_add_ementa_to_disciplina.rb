class AddEmentaToDisciplina < ActiveRecord::Migration[7.2]
  def change
    add_reference :disciplinas, :ementa, null: false, foreign_key: { to_table: :ementas }
    add_reference :disciplinas, :semestre, null: false, foreign_key: true
    remove_column :disciplinas, :nome_disciplina, :string
    remove_column :disciplinas, :semestre, :string
  end
end
