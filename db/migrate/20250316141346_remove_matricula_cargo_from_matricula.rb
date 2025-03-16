class RemoveMatriculaCargoFromMatricula < ActiveRecord::Migration[7.0]
  def change
    remove_column :matriculas, :matricula_cargo_id, :references
  end
end
