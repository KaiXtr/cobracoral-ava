class AddTurnoAndModalidadeToTurma < ActiveRecord::Migration[7.0]
  def change
    add_reference :turmas, :turno_turma, null: false, foreign_key: true
    add_reference :turmas, :modalidade_turma, null: false, foreign_key: true
  end
end
