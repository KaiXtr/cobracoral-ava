class CreateAgendamentos < ActiveRecord::Migration[7.2]
  def change
    create_table :agendamentos do |t|
      t.string :nome_agendamento, null: false
      t.references :usuario, null: false, foreign_key: true
      t.references :local_agendamento, null: true, foreign_key: true
      t.date :data_inicio, null: false
      t.date :data_fim, null: false
      t.time :horario_inicio
      t.time :horario_fim
      t.string :repete

      t.timestamps
    end
  end
end
