class CreateMensagems < ActiveRecord::Migration[7.2]
  def change
    create_table :mensagens do |t|
      t.references :remetente, null: false, foreign_key: { to_table: :usuarios }
      t.references :destinatario, null: false, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
  end
end
