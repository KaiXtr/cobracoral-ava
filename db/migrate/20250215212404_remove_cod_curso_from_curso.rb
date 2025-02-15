class RemoveCodCursoFromCurso < ActiveRecord::Migration[7.0]
  def change
    remove_column :cursos, :cod_curso, :string
  end
end
