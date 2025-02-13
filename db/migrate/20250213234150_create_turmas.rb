class CreateTurmas < ActiveRecord::Migration[7.0]
  def change
    create_table :turmas do |t|
      t.integer :cod_turma
      t.string :nome_turma
      t.string :senha_acesso

      t.timestamps
    end
  end
end
