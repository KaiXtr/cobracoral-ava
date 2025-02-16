class AddCursoToTurma < ActiveRecord::Migration[7.0]
  def change
    add_reference :turmas, :curso, null: false, foreign_key: true
  end
end
