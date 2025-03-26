class AddTurnoAndModalidadeToTurma < ActiveRecord::Migration[7.0]
  def change
    add_column :turmas, :turno_turma, :string, null: false
    add_column :turmas, :modalidade_turma, :string, null: false
  end
end
