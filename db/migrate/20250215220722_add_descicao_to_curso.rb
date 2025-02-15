class AddDescicaoToCurso < ActiveRecord::Migration[7.0]
  def change
    add_column :cursos, :descricao, :string
  end
end
