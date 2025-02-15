class AddSemestreToDisciplina < ActiveRecord::Migration[7.0]
  def change
    add_column :disciplinas, :semestre, :string
  end
end
