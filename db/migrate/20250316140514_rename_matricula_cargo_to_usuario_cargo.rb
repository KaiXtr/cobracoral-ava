class RenameMatriculaCargoToUsuarioCargo < ActiveRecord::Migration[7.0]
  def change
    rename_table :matricula_cargos, :cargo_usuarios
  end
end
