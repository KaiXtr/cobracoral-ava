class AddUsuarioCargoAndAcessosCountToUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :cargo_usuario, :integer, null: false
    add_column :usuarios, :acessos_count, :integer
  end
end
