class RenameMatriculaCargoToUsuarioCargo < ActiveRecord::Migration[7.0]
  def change
    rename_table :matricula_cargos, :usuario_cargos
  end
end
