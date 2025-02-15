class RemoveCodDisciplinaFromDisciplina < ActiveRecord::Migration[7.0]
  def change
    remove_column :disciplinas, :cod_disciplina, :string
  end
end
