class AddVisibilidadeComunicadoToComunicado < ActiveRecord::Migration[7.0]
  def change
    add_reference :comunicados, :visibilidade_comunicado, null: false, foreign_key: true
  end
end
