class CreateLocalAgendamentos < ActiveRecord::Migration[7.2]
  def change
    create_table :local_agendamentos do |t|
      t.string :edificio
      t.string :local

      t.timestamps
    end
  end
end
