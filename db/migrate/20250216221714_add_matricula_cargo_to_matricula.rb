class AddMatriculaCargoToMatricula < ActiveRecord::Migration[7.0]
  def change
    add_reference :matriculas, :matricula_cargo, null: false, foreign_key: true
  end
end
