class CreateModalidadeTurmas < ActiveRecord::Migration[7.0]
  def change
    create_table :modalidade_turmas do |t|
      t.string :enumModalidade

      t.timestamps
    end
  end
end
