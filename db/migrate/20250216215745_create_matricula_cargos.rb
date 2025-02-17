class CreateMatriculaCargos < ActiveRecord::Migration[7.0]
  def change
    create_table :matricula_cargos do |t|
      t.string :enumCargoFeminino
      t.string :enumCargoMasculino

      t.timestamps
    end
  end
end
