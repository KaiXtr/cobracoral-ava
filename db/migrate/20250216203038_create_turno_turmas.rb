class CreateTurnoTurmas < ActiveRecord::Migration[7.0]
  def change
    create_table :turno_turmas do |t|
      t.string :enumTurno

      t.timestamps
    end
  end
end
