class AddUsuarioCargoAndAcessosCountToUsuario < ActiveRecord::Migration[7.0]
  def change
    add_reference :usuarios, :usuario_cargo, null: false, foreign_key: true
    add_column :usuarios, :acessos_count, :integer
  end
end
