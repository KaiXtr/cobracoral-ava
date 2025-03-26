class AddVisibilidadeComunicadoToComunicado < ActiveRecord::Migration[7.0]
  def change
    add_column :comunicados, :visibilidade_comunicado, :integer, null: false
  end
end
