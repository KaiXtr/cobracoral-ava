class AddSemestreToTurma < ActiveRecord::Migration[7.2]
  def change
    add_reference :turmas, :semestre, null: false, foreign_key: true
  end
end
