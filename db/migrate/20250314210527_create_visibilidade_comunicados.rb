class CreateVisibilidadeComunicados < ActiveRecord::Migration[7.0]
  def change
    create_table :visibilidade_comunicados do |t|
      t.string :enumVisibilidade

      t.timestamps
    end
  end
end
