class AddSemestreToMatricula < ActiveRecord::Migration[7.0]
  def change
    add_column :matriculas, :semestre, :string
  end
end
