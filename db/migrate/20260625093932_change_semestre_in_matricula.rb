class ChangeSemestreInMatricula < ActiveRecord::Migration[7.2]
  def change
    remove_column :matriculas, :semestre, :string
    add_reference :matriculas, :semestre, null: false, foreign_key: true
  end
end
