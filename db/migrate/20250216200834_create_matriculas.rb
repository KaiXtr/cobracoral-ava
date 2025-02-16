class CreateMatriculas < ActiveRecord::Migration[7.0]
  def change
    create_table :matriculas do |t|
      t.references :turma, null: false, foreign_key: true
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
