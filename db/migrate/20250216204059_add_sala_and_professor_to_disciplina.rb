class AddSalaAndProfessorToDisciplina < ActiveRecord::Migration[7.0]
  def change
    add_column :disciplinas, :sala_aula, :string
    add_reference :disciplinas, :turma, null: false, foreign_key: true
    add_reference :disciplinas, :usuario, null: false, foreign_key: true
  end
end
